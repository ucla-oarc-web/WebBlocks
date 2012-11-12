require 'rubygems'
require 'extensions/kernel'
require_relative '../Submodule'

module WebBlocks
  
  module Build
    
    module Package
      
      class Selectivizr
        
        include ::WebBlocks::Build::Submodule
        
        def preprocess
          
          preprocess_submodule :selectivizr
          
        end
        
        def reset_package
          
          reset_submodule :selectivizr
          
        end
        
      end
      
    end
    
  end
  
end