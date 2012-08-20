require 'pathname'

module WebBlocks
  
  class Compiler
    
    attr_accessor :src
    attr_accessor :mods
    attr_accessor :adapter
    attr_accessor :extensions
    attr_accessor :sass_dir
    attr_accessor :img_dir
    attr_accessor :js_dir
    attr_accessor :js_core_dir
    attr_accessor :js_core_ie_dir
    attr_accessor :js_scripts_dir
    attr_accessor :dst
    attr_accessor :debug
    attr_accessor :core_dir
    attr_accessor :core_definitions_dir
    attr_accessor :core_adapter_dir
    attr_accessor :core_compass_config
    attr_accessor :adapters_dir
    attr_accessor :root_dir
    
    def initialize config, dst, debug = false
      
      @src = config[:dir]
      @adapter = config[:adapter]
      @extensions = config[:extensions]
      @sass_dir = config[:sass][:dir]
      @img_dir = config[:img][:dir]
      @js_dir = config[:js][:dir]
      @js_core_dir = config[:js][:core][:dir]
      @js_core_ie_dir = config[:js][:core_ie][:dir]
      @js_script_dir = config[:js][:script][:dir]
      @core_dir = config[:core][:dir]
      @core_definitions_dir = config[:core][:definitions][:dir]
      @core_adapter_dir = config[:core][:adapter][:dir]
      @adapters_dir = config[:adapters][:dir]
      @extension_dir = config[:extension][:dir]
      @core_compass_config = config[:core][:compass][:config]
      @dst = dst
      @debug = debug
      @root_dir = Dir.pwd
      
      if config[:modules] == :all
        Dir.chdir @src do
          Dir.chdir @core_dir do
            @mods = []
            Dir.entries("#{@core_definitions_dir}").each do |child|
              @mods.push child unless child[0,1] == '.'
            end
          end
        end
      elsif config[:modules]
        @mods = config[:modules]
      else
        @mods = []
      end
      
    end
    
    def ext? file, ext
      ext = ext.join '|' if ext.respond_to? 'join'
      file.match(/.*\.(#{ext})$/)
    end
    
    def scss? file
      ext? file, 'scss'
    end
    
    def js? file
      ext? file, 'js'
    end
    
    def img? file
      ext? file, ['jpg', 'jpeg', 'gif', 'png', 'bmp', 'tif', 'svg']
    end
    
    def includes
      
      includes = @mods;
      
      Dir.chdir @root_dir do
      
        # map package names to .scss files under core/definitions
        includes.map! do |mod|
          Dir.chdir @src do
            Dir.chdir @core_dir do
              mod = "#{Dir.pwd}/#{@core_definitions_dir}/#{mod}"
            end
          end
        end

        # shift configured adapter(s) to the front of the load chain
        # if array of adapters, FIFO load order so later adapters take precedence
        Dir.chdir @src do
          Dir.chdir @adapters_dir do

            adapter = (@adapter.respond_to? :each) ? @adapter : [@adapter]

            rev_mods = []
            adapter.each { |mod| rev_mods.unshift mod }

            rev_mods.each do |mod| 
              Dir.chdir mod do
                includes.unshift Dir.pwd
              end
            end

          end
        end

        # shift core adapter (for default mixin defs) to the front of load chain
        Dir.chdir @src do
          Dir.chdir @core_dir do
            Dir.chdir @core_adapter_dir do
              includes.unshift Dir.pwd
            end
          end
        end

        if @extensions
          Dir.chdir @src do
            Dir.chdir @extension_dir do
              @extensions.each do |extension|
                Dir.chdir extension do
                  includes.push Dir.pwd
                end
              end
            end
          end
        end
      
      end
      
      return includes
      
    end
    
    def generate
      
      dst_dir = "../#{@dst}"
      Dir.chdir @dst do
        dst_dir = Dir.pwd;
      end
      
      Dir.chdir @src do

        FileUtils.rm_rf "tmp" if File.exists? "tmp";
        mkdir "tmp";

        scss = File.open "tmp/_WebBlocks.scss", "w"

        js = File.open "#{dst_dir}/js/blocks.js", "a"
        js_ie = File.open "#{dst_dir}/js/blocks-ie.js", "a"

        scss.puts "@import \"variables\";"

        includes.each do |mod|
          tree = get_tree mod
          tree.flatten.each do |file|
            case
            when scss?(file)
              puts "[WebBlocks::Compiler mod scss] #{file}"
              file.chomp! ".scss";
              scss.puts "@import \"#{file}\";"
            when js?(file)
              puts "[WebBlocks::Compiler mod js core] #{file}"
              contents = File.read(file)
              js.puts contents
            when img?(file)
              puts "[WebBlocks::Compiler mod img] #{file}"
              relname = file.gsub /^#{mod}\//, ""
              cp_mkdir file, "#{dst_dir}/img/#{relname}"
            end
          end
        end

        if File.exists? @img_dir
          Dir.chdir @img_dir do
            tree = get_tree Dir.pwd
            tree.flatten.each do |file|
              relname = file.gsub /^#{Dir.pwd}\//, ""
              puts "[WebBlocks::Compiler app img] #{file}"
              cp_mkdir file, "#{dst_dir}/img/#{relname}"
            end
          end
        end
        
        if File.exists? @js_dir
          Dir.chdir @js_dir do
            if File.exists? @js_core_dir
              Dir.chdir @js_core_dir do
                tree = get_tree Dir.pwd
                tree.flatten.each do |file|
                  puts "[WebBlocks::Compiler app js core] #{file}"
                  contents = File.read(file)
                  js.puts contents
                end
              end
            end
            if File.exists? @js_core_ie_dir
              Dir.chdir @js_core_ie_dir do
                tree = get_tree Dir.pwd
                tree.flatten.each do |file|
                  puts "[WebBlocks::Compiler app js core-ie] #{file}"
                  contents = File.read(file)
                  js_ie.puts contents
                end
              end
            end
            if File.exists? @js_script_dir
              Dir.chdir @js_script_dir do
                tree = get_tree Dir.pwd
                tree.flatten.each do |file|
                  relname = file.gsub /^#{Dir.pwd}\//, ""
                  puts "[WebBlocks::Compiler app js script] #{file}"
                  puts "#{dst_dir}/js/#{relname}"
                  cp_mkdir file, "#{dst_dir}/js/script/#{relname}"
                end
              end
            end
          end
        end

        scss.close
        js.close
        js_ie.close

        environment = @debug ? "development" : "production"
        
        compass_filename = @core_compass_config
        Dir.chdir @core_dir do
          compass_filename = File.expand_path(compass_filename, Dir.pwd)
        end

        puts "compass compile -e #{environment} --sass-dir #{@sass_dir} --css-dir #{dst_dir}/css --config \"#{compass_filename}\"" 
        sh "compass compile -e #{environment} --sass-dir #{@sass_dir} --css-dir #{dst_dir}/css --config \"#{compass_filename}\"" 

        FileUtils.rm_rf "tmp" if File.exists? "tmp";

      end
      
    end
    
    def get_tree path
      
      contents = []
      
      contents.push path if File.file? path
      
      dir = File.dirname path
      Dir.entries(dir).each do |child|
        contents.push "#{dir}/#{child}" if child.match(/^_?(#{File.basename path})\..*/)
      end

      return contents unless FileTest.directory? path
      
      Dir.entries(path).each do |child|
        contents.push get_tree "#{path}/#{child}" unless child[0,1] == '.'
      end
      
      return contents
      
    end
    
    def cp_mkdir src, dst
      FileUtils.mkdir_p(File.dirname(dst))
      FileUtils.cp src, dst
    end
    
    def execute
      
      self.generate
      
    end
    
  end
  
end