# DO NOT INCLUDE DIRECTLY -- use /lib/Path instead

require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative 'Root'

module WebBlocks
  
  module Path
    
    module Temporary_Build
      
      include ::WebBlocks::Path::Root
      
      def tmp_build_dir
        ::WebBlocks::Path.from_root_to config[:build][:dir_tmp]
      end
      
      def tmp_css_build_dir
        from_tmp_build_dir_to 'css'
      end
      
      def tmp_css_build_file
        from_tmp_build_dir_to 'css', 'blocks.css'
      end
      
      def tmp_css_build_file_ie
        from_tmp_build_dir_to 'css', 'blocks-ie.css'
      end
      
      def tmp_img_build_dir
        from_tmp_build_dir_to 'img'
      end
      
      def tmp_js_build_dir
        from_tmp_build_dir_to 'js'
      end
      
      def tmp_js_build_file
        from_tmp_build_dir_to 'js', 'blocks.js'
      end
      
      def tmp_js_build_file_ie
        from_tmp_build_dir_to 'js', 'blocks-ie.js'
      end
      
      def tmp_js_build_script_dir
        from_tmp_build_dir_to 'js', 'script'
      end
      
      def tmp_sass_lib_dir
        from_tmp_build_dir_to 'sass'
      end
      
      def tmp_sass_lib_file
        from_tmp_build_dir_to 'sass', '_WebBlocks.scss'
      end
      
      def tmp_sass_lib_file_ie
        from_tmp_build_dir_to 'sass', '_WebBlocks-ie.scss'
      end
      
      def tmp_sass_lib_file_require
        from_tmp_build_dir_to 'sass', '_WebBlocks-require.scss'
      end
      
      def tmp_sass_lib_file_require_ie
        from_tmp_build_dir_to 'sass', '_WebBlocks-require-ie.scss'
      end
      
      def tmp_sass_lib_file_variables
        from_tmp_build_dir_to 'sass', '_WebBlocks-variables.scss'
      end
      
      def from_tmp_build_dir_to *args
        args.unshift tmp_build_dir
        ::WebBlocks::Path.from_arr_to(args)
      end
      
    end
    
  end
  
end