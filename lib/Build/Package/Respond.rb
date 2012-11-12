require 'rubygems'
require 'extensions/kernel'
require_relative '../Submodule'

module WebBlocks
  
  module Build
    
    module Package
      
      class Respond
        
        include ::WebBlocks::Build::Submodule
        
        def preprocess
          
          preprocess_submodule :respond
          
        end
        
        def reset_package
          
          reset_submodule :respond
          
        end
        
      end
      
    end
    
  end
  
end