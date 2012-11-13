# DO NOT INCLUDE DIRECTLY -- use /lib/Path instead

require 'rubygems'
require 'extensions/kernel'
require_relative 'Root'

module WebBlocks
  
  module Path
    
    module Source
      
      include ::WebBlocks::Path::Root
      
      def package_dir package
        ::WebBlocks::Path.from_root_to config[:package][:dir], config[:package][package][:dir]
      end
      
      def src_dir *args
        ::WebBlocks::Path.from_root_to config[:src][:dir]
      end
      
      def from_src_dir_to *args
        args.unshift src_dir
        ::WebBlocks::Path.from_arr_to(args)
      end
      
      def src_core_adapter_dir
        from_src_dir_to config[:src][:core][:dir], config[:src][:core][:adapter][:dir]
      end
      
      def from_src_core_adapter_dir_to *args
        args.unshift src_core_adapter_dir
        ::WebBlocks::Path.from_arr_to(args)
      end
      
      def src_core_definitions_dir
        from_src_dir_to config[:src][:core][:dir], config[:src][:core][:definitions][:dir]
      end
      
      def from_src_core_definitions_dir_to *args
        args.unshift src_core_definitions_dir
        ::WebBlocks::Path.from_arr_to(args)
      end
      
      def src_core_compass_config_file
        from_src_dir_to config[:src][:core][:dir], config[:src][:core][:compass][:config]
      end
      
      def src_adapter_dir adapter = false
        if adapter
          from_src_dir_to config[:src][:adapters][:dir], adapter.to_s.downcase
        else
          from_src_dir_to config[:src][:adapters][:dir]
        end
      end
      
      def src_extensions_dir
        from_src_dir_to config[:src][:extension][:dir]
      end
      
      def from_src_extensions_dir_to *args
        args.unshift src_extensions_dir
        ::WebBlocks::Path.from_arr_to(args)
      end
      
      def src_sass_dir
        from_src_dir_to config[:src][:sass][:dir]
      end
      
      def src_sass_includes_dir
         from_src_dir_to config[:src][:sass][:dir], config[:src][:sass][:includes][:dir]
      end
      
      def src_css_dir
        from_src_dir_to config[:src][:css][:dir]
      end
      
    end
    
  end
  
end