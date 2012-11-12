require 'rubygems'
require 'extensions/kernel'
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'

module WebBlocks
  
  module Build
    
    module Package
      
      class Selectivizr
        
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def preprocess
          
          preprocess_submodule :selectivizr
          
        end
        
        def compile
          
          append "#{package_dir :selectivizr}/selectivizr.js", tmp_js_build_file_ie
          
        end
        
        def reset_package
          
          reset_submodule :selectivizr
          
        end
        
      end
      
    end
    
  end
  
end