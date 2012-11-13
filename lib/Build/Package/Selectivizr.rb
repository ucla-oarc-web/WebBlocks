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
          
          preprocess_js
          
        end
        
        def preprocess_js
          
          preprocess_submodule :selectivizr
          
        end
        
        def assemble
          
          assemble_js
          
        end
        
        def assemble_js
          
          log.task "Package: Selectivizr", "Copying Selectivizr sources to IE JS build file" do
            file = "#{package_dir :selectivizr}/selectivizr.js"
            log.debug "#{tmp_js_build_file_ie.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
            append_file file, tmp_js_build_file_ie
          end
          
        end
        
        def reset_package
          
          reset_submodule :selectivizr
          
        end
        
      end
      
    end
    
  end
  
end