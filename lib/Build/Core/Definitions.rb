require 'rubygems'
require 'extensions/kernel'
require_relative '../../Path'
require_relative '../Module'

module WebBlocks
  
  module Build
    
    module Core
      
      class Definitions
        
        include ::WebBlocks::Path::Source
        include ::WebBlocks::Build::Module
        
        def link
          
          link_css
          
        end
        
        def link_css
          
          log.task "Core", "Linking core definitions" do
            link_sass_libs_for src_core_definitions_dir
          end
          
        end
        
      end
      
    end
    
  end
  
end