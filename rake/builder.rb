module WebBlocks
  
  class Builder
    
    attr_accessor :config, :path
    
    def initialize(config)
      @config = config
      @path = {
        :tmp => {
          :dir => @config[:build][:dir_tmp],
          :css => {
            :dir => "#{@config[:build][:dir_tmp]}/#{@config[:build][:css][:dir]}",
            :file => "#{@config[:build][:dir_tmp]}/#{@config[:build][:css][:dir]}/#{@config[:build][:css][:name]}",
            :file_ie => "#{@config[:build][:dir_tmp]}/#{@config[:build][:css][:dir]}/#{@config[:build][:css][:name_ie]}"
          },
          :js => {
            :dir => "#{@config[:build][:dir_tmp]}/#{@config[:build][:js][:dir]}",
            :file => "#{@config[:build][:dir_tmp]}/#{@config[:build][:js][:dir]}/#{@config[:build][:js][:name]}",
            :file_ie => "#{@config[:build][:dir_tmp]}/#{@config[:build][:js][:dir]}/#{@config[:build][:js][:name_ie]}"
          },
          :img => {
            :dir => "#{@config[:build][:dir_tmp]}/#{@config[:build][:img][:dir]}"
          }
        },
        :build => {
          :dir => @config[:build][:dir],
          :css => {
            :dir => "#{@config[:build][:dir]}/#{@config[:build][:css][:dir]}",
            :file => "#{@config[:build][:dir]}/#{@config[:build][:css][:dir]}/#{@config[:build][:css][:name]}",
            :file_ie => "#{@config[:build][:dir]}/#{@config[:build][:css][:dir]}/#{@config[:build][:css][:name_ie]}"
          },
          :js => {
            :dir => "#{@config[:build][:dir]}/#{@config[:build][:js][:dir]}",
            :file => "#{@config[:build][:dir]}/#{@config[:build][:js][:dir]}/#{@config[:build][:js][:name]}",
            :file_ie => "#{@config[:build][:dir]}/#{@config[:build][:js][:dir]}/#{@config[:build][:js][:name_ie]}"
          },
          :img => {
            :dir => "#{@config[:build][:dir]}/#{@config[:build][:img][:dir]}"
          }
        }
      }
    end
    
    def init? 
      return File.exists? WebBlocks.config[:build][:dir_metadata]
    end
    
    def init
      mkdir @config[:build][:dir_metadata]
    end
    
    def reset
      FileUtils.rm_rf @config[:build][:dir_metadata]
    end
    
    def mk_tmp_build_dir
      mkdir @path[:tmp][:dir] unless File.exist? @path[:tmp][:dir]
      mkdir @path[:tmp][:css][:dir] unless File.exists? @path[:tmp][:css][:dir]
      mkdir @path[:tmp][:js][:dir] unless File.exists? @path[:tmp][:js][:dir]
      mkdir @path[:tmp][:img][:dir] unless File.exists? @path[:tmp][:img][:dir]
    end
    
    def touch_tmp_build_files
      File.open @path[:tmp][:css][:file], "w" unless File.exist? @path[:tmp][:css][:file]
      File.open @path[:tmp][:css][:file_ie], "w" unless File.exist? @path[:tmp][:css][:file_ie]
      File.open @path[:tmp][:js][:file], "w" unless File.exist? @path[:tmp][:js][:file]
      File.open @path[:tmp][:js][:file_ie], "w" unless File.exist? @path[:tmp][:js][:file_ie]
    end
    
    def rm_tmp_build_dir
      FileUtils.rm_rf @path[:tmp][:dir] if File.exist? @path[:tmp][:dir]
    end
    
    def mk_build_dir
      mkdir @config[:build][:dir] unless File.exist? @config[:build][:dir]
      mkdir @path[:build][:css][:dir] unless File.exist? @path[:build][:css][:dir]
      mkdir @path[:build][:js][:dir] unless File.exist? @path[:build][:js][:dir]
      mkdir @path[:build][:img][:dir] unless File.exist? @path[:build][:img][:dir]
    end
    
    def rm_build_dir
      FileUtils.rm_rf @config[:build][:dir] if File.exist?(@config[:build][:dir])
    end
    
    def generate_build_files
      Dir.entries(@path[:tmp][:img][:dir]).each do |name|
        FileUtils.cp_r "#{@path[:tmp][:img][:dir]}/#{name}", @path[:build][:img][:dir] unless name[0,1] == '.'
      end
      sh "#{@config[:exec][:uglifycss]} \"#{@path[:tmp][:css][:file]}\" > \"#{@path[:build][:css][:file]}\""
      sh "#{@config[:exec][:uglifyjs]} \"#{@path[:tmp][:js][:file]}\" --extras --unsafe > \"#{@path[:build][:js][:file]}\""
      sh "#{@config[:exec][:uglifycss]} \"#{@path[:tmp][:css][:file_ie]}\" > \"#{@path[:build][:css][:file_ie]}\""
      sh "#{@config[:exec][:uglifyjs]} \"#{@path[:tmp][:js][:file_ie]}\" --extras --unsafe > \"#{@path[:build][:js][:file_ie]}\""
    end
    
    def update_packages
      sh "#{@config[:exec][:git]} submodule init"
      sh "#{@config[:exec][:git]} submodule update"
    end
    
    def package?(name)
      return @config[:build][:packages].include? name
    end
    
    def append_sass
      pwd = Dir.pwd
      Dir.chdir @config[:src][:dir]
      puts "#{@config[:exec][:compass]} compile --sass-dir #{@config[:src][:sass]} --css-dir ../#{@path[:tmp][:dir]}/css" 
      sh "#{@config[:exec][:compass]} compile --sass-dir #{@config[:src][:sass]} --css-dir ../#{@path[:tmp][:dir]}/css" 
      Dir.chdir pwd
      self.append_contents_to_file "#{@path[:tmp][:dir]}/css/site.css", @path[:tmp][:css][:file]
      self.append_contents_to_file "#{@path[:tmp][:dir]}/css/site-ie.css", @path[:tmp][:css][:file_ie]
    end
    
    def append_jquery_js
      src = "#{@config[:package][:dir]}/#{@config[:package][:jquery][:dir]}/dist/jquery.min.js"
      self.append_contents_to_file src, @path[:tmp][:js][:file]
    end
    
    def append_bootstrap_js
      src_dir = "#{@config[:package][:dir]}/#{@config[:package][:bootstrap][:dir]}"
      @config[:package][:bootstrap][:scripts].each do |script|
        self.append_contents_to_file "#{src_dir}/js/bootstrap-#{script}.js", @path[:tmp][:js][:file]
      end
    end
    
    def copy_bootstrap_images
      src_dir = "#{@config[:package][:dir]}/#{@config[:package][:bootstrap][:dir]}"
      Dir.entries("#{src_dir}/img/").each do |name|
        FileUtils.cp "#{src_dir}/img/#{name}", @path[:tmp][:img][:dir] unless File.directory? "#{src_dir}/img/#{name}"
      end
    end
    
    def append_modernizr_js
      src = "#{@config[:package][:dir]}/#{@config[:package][:modernizr][:dir]}/modernizr.js"
      self.append_contents_to_file src, @path[:tmp][:js][:file]
    end
    
    def append_respond_js
      src = "#{@config[:package][:dir]}/#{@config[:package][:respond][:dir]}/respond.min.js"
      self.append_contents_to_file src, @path[:tmp][:js][:file_ie]
    end
    
    def append_selectivizr_js
      src = "#{@config[:package][:dir]}/#{@config[:package][:selectivizr][:dir]}/selectivizr.js"
      self.append_contents_to_file src, @path[:tmp][:js][:file_ie]
    end
    
    def append_contents_to_file(src, dst)
      puts "cat #{src} >> #{dst}"
      contents = File.read(src)
      File.open(dst, "a") do |handle|
        handle.puts contents
      end
    end
    
    class JQuery
      
      attr_accessor :config, :build_path
    
      def initialize(config)
        @config = config
        @path = "#{@config[:package][:dir]}/#{@config[:package][:jquery][:dir]}"
      end
      
      def update
        pwd = Dir.pwd
        Dir.chdir @path
        sh "#{@config[:exec][:git]} submodule init"
        sh "#{@config[:exec][:git]} submodule update"
        Dir.chdir pwd
      end
      
      def build
        if File.exist? "#{@path}/dist"
          return false
        end
        pwd = Dir.pwd
        Dir.chdir @path
        sh "#{@config[:exec][:npm]} install"
        sh "#{@config[:exec][:grunt]}"
        Dir.chdir pwd
        return true
      end
      
      def clean
        FileUtils.rm_rf "#{@path}/dist"
      end
      
    end
    
  end

end