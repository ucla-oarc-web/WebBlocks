require 'rubygems'
require 'extensions/kernel'
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'

module WebBlocks
  
  module Build
    
    module Package
      
      class Respond
        
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def preprocess
          
          preprocess_submodule :respond
          
        end
        
        def compile
          
          append "#{package_dir :respond}/respond.src.js", tmp_js_build_file_ie
          
        end
        
        def reset_package
          
          reset_submodule :respond
          
        end
        
      end
      
    end
    
  end
  
end