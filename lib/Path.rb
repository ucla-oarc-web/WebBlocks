require 'pathname'

module WebBlocks
  
  module Path
    
    module Source
      
      def package_dir package
        ::WebBlocks::Path.from_root_to config[:package][:dir], config[:package][package][:dir]
      end
      
    end
    
    module Temporary_Build
      
      def tmp_build_dir
        ::WebBlocks::Path.from_root_to config[:build][:dir_tmp]
      end
      
      def tmp_css_build_dir
        from_tmp_build_dir_to config[:build][:css][:dir]
      end
      
      def tmp_css_build_file
        from_tmp_build_dir_to config[:build][:css][:dir], config[:build][:css][:name]
      end
      
      def tmp_css_build_file_ie
        from_tmp_build_dir_to config[:build][:css][:dir], config[:build][:css][:name_ie]
      end
      
      def tmp_img_build_dir
        from_tmp_build_dir_to config[:build][:img][:dir]
      end
      
      def tmp_js_build_dir
        from_tmp_build_dir_to config[:build][:js][:dir]
      end
      
      def tmp_js_build_file
        from_tmp_build_dir_to config[:build][:js][:dir], config[:build][:js][:name]
      end
      
      def tmp_js_build_file_ie
        from_tmp_build_dir_to config[:build][:js][:dir], config[:build][:js][:name_ie]
      end
      
      def tmp_js_build_script_dir
        from_tmp_build_dir_to config[:build][:js][:dir], config[:build][:js][:name_script_dir]
      end
      
      def from_tmp_build_dir_to *args
        args.unshift tmp_build_dir
        ::WebBlocks::Path.from_arr_to(args)
      end
      
    end
    
    module Build
      
      def build_dir
        ::WebBlocks::Path.from_root_to config[:build][:dir]
      end
      
      def from_build_dir_to *args
        args.unshift build_dir
        ::WebBlocks::Path.from_arr_to(args)
      end
      
    end
    
    def self.to *args
      ::WebBlocks::Path.from_arr_to(args)
    end
    
    def self.from_arr_to args
      
      return Dir.pwd unless args and args.length > 0
      
      subdir = args.shift
      begin
        Dir.chdir subdir do
          ::WebBlocks::Path.from_arr_to(args)
        end
      rescue
        if args.length == 0
          begin
            Dir.chdir File.dirname(subdir) do
              return "#{Dir.pwd}/#{File.basename(subdir)}"
            end
          rescue
            false
          end
        end
        false
      end
      
    end
    
    def self.from_root_to *args
      
      Dir.chdir File.dirname(File.dirname(Pathname.new(__FILE__).realpath)) do
        ::WebBlocks::Path.from_arr_to(args)
      end
      
    end
    
  end
  
end