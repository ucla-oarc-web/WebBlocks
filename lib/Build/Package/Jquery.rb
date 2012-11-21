require 'rubygems'
require 'extensions/kernel'
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'
require_relative '../../Logger'

module WebBlocks
  
  module Build
    
    module Package
      
      class Jquery
        
        include ::WebBlocks::Logger
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def preprocess
          
          preprocess_js
          
        end
        
        def preprocess_js
          
          preprocess_submodule :jquery
          preprocess_submodule_submodules :jquery
          preprocess_submodule_npm :jquery
          
        end
        
        def compile
          
          compile_js
          
        end
        
        def compile_js
          
          unless File.exists? "#{package_dir :jquery}/dist/jquery.js"
            
            log.task "Package: jQuery", "Compiling jQuery" do
              Dir.chdir package_dir :jquery do
                status, stdout, stderr = systemu "#{config[:exec][:npm]} install"
                log.failure "Builder: jQuery", "NPM execution failed" if stderr.length > 0
                status, stdout, stderr = systemu "#{config[:exec][:grunt]}"
                log.failure "Builder: jQuery", "Grunt execution failed" if stderr.length > 0
              end
            end
            
          end
          
        end
        
        def assemble
          
          assemble_js
          
        end
        
        def assemble_js
          
          log.task "Package: jQuery", "Copying jQuery sources to JS build file" do
            file = "#{package_dir :jquery}/dist/jquery.js"
            log.debug "#{tmp_js_build_file.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
            append_file file, tmp_js_build_file
          end
          
        end
        
        def clean_package
          
          FileUtils.rm_rf "#{package_dir :jquery}/dist" if File.exists? "#{package_dir :jquery}/dist"
          
        end
        
        def reset_package
          
          reset_submodule :jquery
          
        end
        
      end
      
    end
    
  end
  
end