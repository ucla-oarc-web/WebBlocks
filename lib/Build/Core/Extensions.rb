require 'rubygems'
require 'extensions/kernel'
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'

module WebBlocks
  
  module Build
    
    module Core
      
      class Extensions
        
        include ::WebBlocks::Path::Source
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def link
          
          
          
        end
        
      end
      
    end
    
  end
  
end