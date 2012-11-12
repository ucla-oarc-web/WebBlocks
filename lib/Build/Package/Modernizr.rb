require 'rubygems'
require 'extensions/kernel'
require_relative '../Submodule'

module WebBlocks
  
  module Build
    
    module Package
      
      class Modernizr
        
        include ::WebBlocks::Build::Submodule
        
        def preprocess
          
          preprocess_submodule :modernizr
          
        end
        
        def reset_package
          
          reset_submodule :modernizr
          
        end
        
      end
      
    end
    
  end
  
end