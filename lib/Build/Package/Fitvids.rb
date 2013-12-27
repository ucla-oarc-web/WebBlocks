require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'
require_relative '../../Logger'

module WebBlocks
  
  module Build
    
    module Package
      
      class Fitvids
        
        include ::WebBlocks::Logger
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def preprocess
          
          preprocess_js
          
        end
        
        def preprocess_js
          
          preprocess_submodule :fitvids

          packages = (config[:src][:packages] | config[:build][:packages])
          
          if packages.include? :jquery
            log.failure "Package: FitVids", "Package jquery must be loaded before fitvids" if packages.index(:jquery) > packages.index(:fitvids)
          else
            log.warning "Package: FitVids", "Package jquery required but not included -- ensure it is loaded externally"
          end
          
        end
        
        def assemble
          
          assemble_js
          
        end
        
        def assemble_js
          
          file = "jquery.fitvids.js"
          log.task "Package: FitVids", "Copying #{file} to JS build file" do
            file = "#{package_dir :fitvids}/#{file}"
            log.debug "#{tmp_js_build_file.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
            append_file file, tmp_js_build_file, ';'
          end
          
        end
        
        def reset_package
          
          reset_submodule :fitvids
          
        end
        
      end
      
    end
    
  end
  
end