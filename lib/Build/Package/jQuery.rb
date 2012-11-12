require 'rubygems'
require 'extensions/kernel'
require_relative '../Package'

module WebBlocks
  
  module Build
    
    module Package
      
      class Jquery
        
        include ::WebBlocks::Build::Package
        include ::WebBlocks::Path::Sources
        
        def setup_build
          
          init_submodule :jquery
          update_submodule :jquery
          
          unless File.exists?  "#{package_dir :jquery}/dist/jquery.js"
            
            log.task "Package: jQuery", "Compiling jQuery" do
              Dir.chdir package_dir :jquery do
                log.failure "Builder: jQuery", "NPM execution failed" unless systemu "#{config[:exec][:npm]} install"
                log.failure "Builder: jQuery", "Grunt execution failed" unless systemu "#{config[:exec][:grunt]}"
              end
            end
            
          end
          
        end
        
        def build
          
          # TODO
          
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