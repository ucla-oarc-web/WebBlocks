require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'
require_relative '../../Logger'

module WebBlocks
  
  module Build
    
    module Package
      
      class Adaptiveimages
        
        include ::WebBlocks::Logger
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def assemble
          
          assemble_js
          
        end
        
        def assemble_js
          
          log.task "Package: AdaptiveImages", "Add Adaptive Images hook to JS build file" do
            if config[:package][:adaptiveimages].include?(:pixel_density) and config[:package][:adaptiveimages][:pixel_density]
              contents = "document.cookie='resolution='+Math.max(screen.width,screen.height)+(\"devicePixelRatio\" in window ? \",\"+devicePixelRatio : \",1\")+'; path=/';"
            else
              contents = "document.cookie='resolution='+Math.max(screen.width,screen.height)+'; path=/';"
            end
            File.open(tmp_js_build_file, "a") { |handle| handle.puts "#{contents};" }
          end
          
        end
        
      end
      
    end
    
  end
  
end