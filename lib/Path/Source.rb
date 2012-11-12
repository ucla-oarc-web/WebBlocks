# DO NOT INCLUDE DIRECTLY -- use /lib/Path instead

module WebBlocks
  
  module Path
    
    module Source
      
      def package_dir package
        ::WebBlocks::Path.from_root_to config[:package][:dir], config[:package][package][:dir]
      end
      
    end
    
  end
  
end