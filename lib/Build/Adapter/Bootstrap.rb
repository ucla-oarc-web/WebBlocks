require 'rubygems'
require 'extensions/kernel'
require_relative '../Submodule'

module WebBlocks
  
  module Build
    
    module Adapter
      
      class Bootstrap
        
        include ::WebBlocks::Build::Submodule
        
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