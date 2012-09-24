require 'fileutils'
require 'pathname'
require 'systemu'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/util.rb"
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/compiler.rb"
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/adapter/compiler.rb"

module WebBlocks
  
  module Build
    
    class Blocks < Builder
      
      def init
        
        puts ".. Defining WebBlocks metadata"
        FileUtils.mkdir_p dir_build_metadata unless init?
        
      end
      
      def init?
        
        File.exists? dir_build_metadata
        
      end
      
      def reset
        
        puts ".. Resetting WebBlocks to initial state"
        FileUtils.rm_rf dir_build_metadata
        
      end
      
      def build_setup
        
        # TODO move this back to build_cleanup once dev is done
        FileUtils.rm_rf dir_build_temp
        
        fail "[ERROR] Temporary build directory already exists [run `rake clean` to resolve]" if File.exists? dir_build_temp
        puts ".. Setting up temporary region for build"
        
        FileUtils.mkdir_p dir_build_temp 
        FileUtils.touch file_build_temp_css
        FileUtils.touch file_build_temp_css_ie
        FileUtils.touch file_build_temp_js
        FileUtils.touch file_build_temp_js_ie
        FileUtils.mkdir_p dir_build_temp_js
        FileUtils.mkdir_p dir_build_temp_img
        
      end
      
      def build
        
        puts ".. Compiling WebBlocks"
        
        compiler = WebBlocks::Build::Blocks::Compiler.new(@config)
        compiler.compile
        
        puts ".. Appending compiled files to build"
        
        WebBlocks::Util.get_files(dir_build_temp_css, 'css').each do |file|
          append_contents_to_file file, (file.match(/.*\-ie.css$/) ? file_build_temp_css_ie : file_build_temp_css)
        end
        
        puts ".. Copying build from temporary region into build targets"
        
        FileUtils.mkdir_p @config[:build][:dir] unless File.exists? @config[:build][:dir]
        Dir.chdir @config[:build][:dir] do
          
          FileUtils.mkdir_p @config[:build][:css][:dir] unless File.exists? @config[:build][:css][:dir]
          Dir.chdir @config[:build][:css][:dir] do
            
            src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_css
            dst = Pathname.new(@config[:build][:css][:name]).realpath
            FileUtils.mkdir_p File.dirname(dst)
            puts ".... Core CSS file to #{dst}"
            FileUtils.cp src, dst
            
            src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_css_ie
            dst = Pathname.new(@config[:build][:css][:name_ie]).realpath
            FileUtils.mkdir_p File.dirname(dst)
            puts ".... IE CSS file to #{dst}"
            FileUtils.cp src, dst
            
          end
          
          FileUtils.mkdir_p @config[:build][:js][:dir] unless File.exists? @config[:build][:js][:dir]
          Dir.chdir @config[:build][:js][:dir] do
            
            src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_js
            dst = Pathname.new(@config[:build][:js][:name]).realpath
            FileUtils.mkdir_p File.dirname(dst)
            puts ".... Core JS file to #{dst}"
            FileUtils.cp src, dst
            
            src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_js_ie
            dst = Pathname.new(@config[:build][:js][:name_ie]).realpath
            FileUtils.mkdir_p File.dirname(dst)
            puts ".... IE JS file to #{dst}"
            FileUtils.cp src, dst
            
            src = WebBlocks::Util.dir_from_root_through_dir_stack dir_build_temp_js
            dst = Pathname.new(@config[:build][:js][:name_script_dir]).realpath
            FileUtils.mkdir_p File.dirname(dst)
            puts ".... JS scripts to #{dst}"
            FileUtils.cp_r src, dst
            
          end
          
          src = WebBlocks::Util.dir_from_root_through_dir_stack dir_build_temp_img
          dst = Pathname.new(@config[:build][:img][:dir]).realpath
          FileUtils.mkdir_p File.dirname(dst)
          puts ".... Images to #{dst}"
          FileUtils.cp_r src, dst
          
        end
        
      end
      
      def build_cleanup
        #FileUtils.rm_rf dir_build_temp
      end
      
      def built?
        File.exists? dir_build
      end

      def clean
        build_cleanup
        FileUtils.rm_rf dir_build
      end
      
      class Compiler < WebBlocks::Build::Compiler
        
        attr_accessor :adapters
        attr_accessor :adapters_compilers
        attr_accessor :extensions
        attr_accessor :modules
        attr_accessor :file_build_temp_sass
        attr_accessor :dir_src_sass
        attr_accessor :dir_src_core
        attr_accessor :dir_src_core_definitions
        attr_accessor :dir_src_core_adapter
        attr_accessor :file_src_core_compass_config
        attr_accessor :dir_src_extensions
        
        def initialize config
          
          super config
          
          @file_build_temp_sass = "#{dir_build_temp_sass}/_WebBlocks.scss"
          @dir_src_sass = WebBlocks::Util.dir_from_root_through_dir_stack dir_src, @config[:src][:sass][:dir]
          @dir_src_core = WebBlocks::Util.dir_from_root_through_dir_stack dir_src, @config[:src][:core][:dir]
          @dir_src_core_definitions = WebBlocks::Util.dir_from_dir_stack @dir_src_core, @config[:src][:core][:definitions][:dir]
          @dir_src_core_adapter = WebBlocks::Util.dir_from_root_through_dir_stack @dir_src_core, @config[:src][:core][:adapter][:dir]
          @dir_src_extensions = WebBlocks::Util.dir_from_dir_stack dir_src, @config[:src][:extension][:dir]
          @file_src_core_compass_config = WebBlocks::Util.file_from_dir_stack @dir_src_core, @config[:src][:core][:compass][:config]
          
          if @config[:src][:adapter]
            @adapters = (@config[:src][:adapter].respond_to? :each) ? @config[:src][:adapter] : [@config[:src][:adapter]]
          else
            @adapters = []
          end
          
          @adapters_compilers = []
          @adapters.each do |name|
            file = "#{File.dirname(Pathname.new(__FILE__).realpath)}/adapter/#{name.to_s}.rb"
            if File.exists? file
              load file
              classname = eval "WebBlocks::Build::Adapter::#{name.to_s.capitalize}"
              begin
                @adapters_compilers.push(classname.new(@config))
                puts "[INITIALIZE] #{classname}"
              rescue
                fail "[INITIALIZE ERROR] WebBlocks::Build::Adapter::#{name.to_s.capitalize}"
              end
            else
              @adapters_compilers.push(WebBlocks::Build::Adapter::Compiler.new(@config, name.to_s.downcase))
              puts "[INITIALIZE] WebBlocks::Build::Adapter::Compiler"
            end
          end
          
          # Add core adapter as first adapter
          @adapters_compilers.unshift WebBlocks::Build::Adapter::Compiler.new(@config, @dir_src_core_adapter)
          
          @core_definitions_compiler = WebBlocks::Build::Adapter::Compiler.new(@config, @dir_src_core_definitions)
          
          if @config[:src][:extensions]
            @extensions = (@config[:src][:extensions].respond_to? :each) ? @config[:src][:extensions] : [@config[:src][:extensions]]
          else
            @extensions = []
          end
          
          if @config[:src][:modules] == :all
            @modules = []
            get_modules(dir_src_core_definitions, false).each do |mod|
              @modules.push mod.sub /^#{Regexp.escape(dir_src_core_definitions)}\//, ''
            end
          elsif @config[:src][:modules]
            @modules = (@config[:src][:modules].respond_to? :each) ? @config[:src][:modules] : [@config[:src][:modules]]
          else
            @modules = []
          end
          
        end
        
        def dir_src_extension path
          WebBlocks::Util.dir_from_dir_stack dir_src_extensions, path
        end
        
        def dir_src_core_definition path
          WebBlocks::Util.dir_from_dir_stack dir_src_core_definitions, path
        end
        
        def compile
          
          puts ".... Generating SASS import file"
          create_sass_import_file file_build_temp_sass
          
          puts ".... Running Compass compiler"
          run_compass_compiler
          
          puts ".... Copy Javascript sources"
          append_javascript 
          
          puts ".... CSS files generated by Compass compiler"
          
        end
        
        def create_sass_import_file file
          FileUtils.mkdir_p File.dirname(file)
          File.open file, "w" do |scss|
            included_scss_files.each do |include|
              scss.puts "@import \"#{include}\";"
            end
          end
        end
        
        def run_compass_compiler
          success = true
          environment = @config[:build][:debug] ? "development" : "production"
          Dir.chdir @config[:build][:dir_tmp] do
            status, stdout, stderr = systemu "compass compile -e #{environment} --sass-dir #{dir_src_sass} --config \"#{@file_src_core_compass_config}\""
            success = false if status != 0
          end
          fail "[ERROR] Compass compile error" unless success
        end
        
        def append_javascript
          @adapters_compilers.each do |adapter_compiler|
            adapter_compiler.included_adapter_module_files(@modules, 'js').each do |file|
              WebBlocks::Util.append_contents_to_file file, (file.match(/.*\-ie.js$/) ? file_build_temp_js_ie : file_build_temp_js)
            end
          end
        end
        
        def included_files ext
          files = []
          @adapters_compilers.each do |adapter_compiler|
            files.push adapter_compiler.included_adapter_module_files(@modules, ext)
          end
          @extensions.each do |path|
            files.push get_files(dir_src_extension(path), ext)
          end
          files.push @core_definitions_compiler.included_adapter_module_files(@modules, ext)
          #@modules.each do |path|
          #  files.push(get_files(dir_src_core_definition(path), ext))
          #  ext = [ext] unless ext.respond_to? :each
          #  ext.each do |e|
          #    files.push ["#{dir_src_core_definitions}/#{path}.#{e}"] if File.exists? "#{dir_src_core_definitions}/#{path}.#{e}"
          #    files.push ["#{dir_src_core_definitions}/#{File.dirname(path)}/_#{File.basename(path)}.#{e}"] if File.exists? "#{dir_src_core_definitions}/#{File.dirname(path)}/_#{File.basename(path)}.#{e}"
          #  end
          #end
          files.flatten
        end
        
        def included_scss_files
          files = [[],[]]
          included_files("scss").each do |file|
            if File.basename(file) == '_variables.scss' or File.basename(file) == 'variables.scss'
              files[0].push file
            else
              files[1].push file
            end
          end
          files[0].push "#{dir_src_sass}/_variables.scss" if File.exists? "#{dir_src_sass}/_variables.scss"
          files.flatten
        end
        
        def included_js_files
          included_files "js"
        end
        
      end
      
    end
    
  end
  
end