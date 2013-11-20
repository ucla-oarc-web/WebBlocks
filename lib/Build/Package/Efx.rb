require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'
require_relative '../../Logger'

module WebBlocks
  
  module Build
    
    module Package
      
      class Efx
        
        include ::WebBlocks::Logger
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def preprocess
          
          preprocess_submodule :efx
          
        end
        
        def preprocess_js
          
          preprocess_submodule :efx
          
        end

        def preprocess_css

          preprocess_submodule :efx

        end
        
        def assemble
          
          assemble_js
          assemble_css
          
        end
        
        def assemble_js
          
          log.task "Package: Efx", "Copying Efx engine to JS build file" do
            file = "#{package_dir :efx}/src/engine.js"
            log.debug "#{tmp_js_build_file.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
            append_file file, tmp_js_build_file, ';'
          end
          
          log.task "Package: Efx", "Copying Efx drivers to JS build file" do
            dir = "#{package_dir :efx}/src/driver"
            Dir.entries(dir).each do |file|
              next if file[0,1] == '.'
              src = "#{dir}/#{file}"
              dst = false
              if file.match /\.js$/
                dst = tmp_js_build_file
                append_file src, dst, ';' 
              end
              log.debug "#{dst.gsub /^#{root_dir}\//, ''} <<- #{src.gsub /^#{root_dir}\//, ''}" if dst
            end
          end
          
        end

        def assemble_css

          log.task "Package: Efx", "Copying Efx drivers to CSS build file" do
            dir = "#{package_dir :efx}/src/driver"
            Dir.entries(dir).each do |file|
              next if file[0,1] == '.'
              src = "#{dir}/#{file}"
              dst = false
              if file.match /\.css$/
                dst = tmp_css_build_file
                append_file src, dst
              end
              log.debug "#{dst.gsub /^#{root_dir}\//, ''} <<- #{src.gsub /^#{root_dir}\//, ''}" if dst
            end
          end

        end
        
        def reset_package
          
          reset_submodule :efx
          
        end
        
      end
      
    end
    
  end
  
end