require 'rubygems'
require 'extensions/kernel'
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'
require_relative '../Module'

module WebBlocks
  
  module Build
    
    module Adapter
      
      class Bootstrap
        
        include ::WebBlocks::Path::Source
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        include ::WebBlocks::Build::Module
        
        def preprocess
          
          preprocess_submodule :bootstrap
          
        end
        
        def link
          
          log.task "Adapter", "Linking bootstrap adapter" do
            link_sass_libs_for src_adapter_dir :bootstrap
          end
          
        end
        
        def reset_package
          
          reset_submodule :bootstrap
          
        end
        
      end
      
    end
    
  end
  
end