require 'rubygems'
require 'extensions/kernel'
require_relative '../Package'

module WebBlocks
  
  module Build
    
    module Package
      
      class Jquery
        
        include ::WebBlocks::Build::Package
        
        def preprocess
          
          preprocess_submodule :jquery
          
        end
        
        def compile
          
          unless File.exists?  "#{package_dir :jquery}/dist/jquery.js"
            
            log.task "Package: jQuery", "Compiling jQuery" do
              Dir.chdir package_dir :jquery do
                log.failure "Builder: jQuery", "NPM execution failed" unless systemu "#{config[:exec][:npm]} install"
                log.failure "Builder: jQuery", "Grunt execution failed" unless systemu "#{config[:exec][:grunt]}"
              end
            end
            
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