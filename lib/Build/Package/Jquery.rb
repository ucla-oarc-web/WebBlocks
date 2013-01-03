require 'rubygems'
require 'extensions/kernel'
require 'net/http'
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'
require_relative '../../Logger'

module WebBlocks
  
  module Build
    
    module Package
      
      class Jquery
        
        def domain
          'code.jquery.com'
        end
        
        def path
          config[:build][:debug] ? '/jquery-1.8.3.js' : '/jquery-1.8.3.min.js'
        end
        
        include ::WebBlocks::Logger
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def compile
          
          compile_js
          
        end
        
        def compile_js
          
          filename =  "#{package_dir :jquery}/dist/jquery.js"
          
          unless File.exists? filename
            
            log.task "Package: jQuery", "Downloading compiled version of jQuery" do
              Net::HTTP.start(domain) do |http|
                resp = http.get(path)
                FileUtils.mkdir_p File.dirname(filename)
                open(filename, "w") do |file|
                  file.write(resp.body)
                end
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