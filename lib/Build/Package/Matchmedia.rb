require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'
require_relative '../../Logger'

module WebBlocks
  
  module Build
    
    module Package
      
      class Matchmedia
        
        include ::WebBlocks::Logger
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def preprocess
          
          preprocess_js
          
        end
        
        def preprocess_js
          
          preprocess_submodule :matchMedia
          
        end
        
        def assemble
          
          assemble_js
          
        end
        
        def assemble_js
          
          files = []
          files << "matchMedia.js"
          files << "matchMedia.addListener.js" if config[:package][:matchMedia][:include_listener]
          
          files.each do |file|
            log.task "Package: matchMedia", "Copying #{file} to JS build file" do
              file = "#{package_dir :matchMedia}/#{file}"
              log.debug "#{tmp_js_build_file.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
              append_file file, tmp_js_build_file, ';'
            end
          end
          
        end
        
        def reset_package
          
          reset_submodule :matchMedia
          
        end
        
      end
      
    end
    
  end
  
end