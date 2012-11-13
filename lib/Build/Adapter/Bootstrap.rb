require 'rubygems'
require 'extensions/kernel'
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'
require_relative '../Module'

module WebBlocks
  
  module Build
    
    module Adapter
      
      class Bootstrap
        
        include ::WebBlocks::Path::Source
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        include ::WebBlocks::Build::Module
        
        def preprocess
          
          preprocess_submodule :bootstrap
          
        end
        
        def link
          
          link_css
          
        end
        
        def link_css
          
          log.task "Adapter: Bootstrap", "Linking bootstrap adapter" do
            link_sass_libs_for src_adapter_dir :bootstrap
          end
          
        end
        
        def assemble
          
          assemble_img
          assemble_js
          
        end
        
        def assemble_img
          
          dir = "#{package_dir :bootstrap}/img"
          
          log.task "Adapter: Bootstrap", "Copying images from Bootstrap" do
            get_files(dir).each do |file|
              log.debug "#{tmp_img_build_dir.gsub /^#{root_dir}\//, ''} <- #{file.gsub /^#{root_dir}\//, ''}"
              FileUtils.cp_r file, "#{tmp_img_build_dir}/#{file.gsub /^#{dir}\//, ''}"
            end
          end
          
        end
        
        def assemble_js
          
          base = "#{package_dir :bootstrap}/js/bootstrap"
          
          log.task "Adapter: Bootstrap", "Copying JS from Bootstrap" do
            
            scripts = config[:package][:bootstrap][:scripts] ? config[:package][:bootstrap][:scripts] : []
            
            scripts.each do |script|
              file = "#{base}-#{script}.js"
              if File.exists? file
                log.debug "#{tmp_js_build_file.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
                append_file file, tmp_js_build_file
              end
            end
          end
          
        end
        
        def reset_package
          
          reset_submodule :bootstrap
          
        end
        
      end
      
    end
    
  end
  
end