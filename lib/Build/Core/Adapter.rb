require 'rubygems'
require 'extensions/kernel'
require_relative '../../Path'
require_relative '../Module'
require_relative '../Utilities'

module WebBlocks
  
  module Build
    
    module Core
      
      class Adapter
        
        include ::WebBlocks::Path::Source
        include ::WebBlocks::Build::Module
        
        def preprocess
          
          preprocess_css
          
        end
        
        def preprocess_css
          
          log.task "Core: Adapter", "Resolving SASS dependenties in core adapter" do
            resolve_sass_dependencies src_core_adapter_dir 
          end
          
        end
        
        def link
          
          link_css
          
        end
        
        def link_css
          
          log.task "Core: Adapter", "Linking core adapter" do
            link_sass_libs_for src_core_adapter_dir
          end
          
        end
        
        def assemble
          
          assemble_img
          assemble_js
          
        end
        
        def assemble_img
          
          log.task "Core: Adapter", "Copying images from core adapter" do
            assemble_img_files_for src_core_adapter_dir
          end
          
        end
        
        def assemble_js
          
          log.task "Core: Adapter", "Copying JS from core adapter" do
            assemble_js_libs_for src_core_adapter_dir
          end
          
        end
        
      end
      
    end
    
  end
  
end