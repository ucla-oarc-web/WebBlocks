require 'rubygems'
require 'extensions/kernel'
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'

module WebBlocks
  
  module Build
    
    module Adapter
      
      class Bootstrap
        
        include ::WebBlocks::Path::Source
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def preprocess
          
          preprocess_submodule :bootstrap
          
        end
        
        def reset_package
          
          reset_submodule :bootstrap
          
        end
        
      end
      
    end
    
  end
  
end