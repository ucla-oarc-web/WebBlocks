require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative '../../Path'
require_relative '../Module'
require_relative '../../Logger'

module WebBlocks
  
  module Build
    
    module Core
      
      class Definitions
        
        include ::WebBlocks::Logger
        include ::WebBlocks::Path::Source
        include ::WebBlocks::Build::Module
        
        def preprocess
          
          preprocess_css
          
        end
        
        def preprocess_css
          
          log.task "Core: Definitions", "Resolving SASS dependenties in core definitions" do
            resolve_sass_dependencies src_core_definitions_dir
          end
          
        end
        
        def link
          
          link_css
          
        end
        
        def link_css
          
          log.task "Core: Definitions", "Linking core definitions" do
            link_sass_libs_for src_core_definitions_dir, false
          end
          
        end
        
        def assemble
          
          assemble_img
          assemble_js
          
        end
        
        def assemble_img
          
          log.task "Core: Definitions", "Copying images from core definitions" do
            assemble_img_files_for src_core_definitions_dir
          end
          
        end
        
        def assemble_js
          
          log.task "Core: Definitions", "Copying JS from core definitions" do
            assemble_js_libs_for src_core_definitions_dir
          end
          
        end
        
      end
      
    end
    
  end
  
end