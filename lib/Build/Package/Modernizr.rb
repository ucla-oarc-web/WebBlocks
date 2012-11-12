require 'rubygems'
require 'extensions/kernel'
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'

module WebBlocks
  
  module Build
    
    module Package
      
      class Modernizr
        
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def preprocess
          
          preprocess_submodule :modernizr
          
        end
        
        def compile
          
          append "#{package_dir :modernizr}/modernizr.js", tmp_js_build_file
          
        end
        
        def reset_package
          
          reset_submodule :modernizr
          
        end
        
      end
      
    end
    
  end
  
end