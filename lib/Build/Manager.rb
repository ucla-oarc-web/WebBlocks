require 'observer'
require_relative 'WebBlocks'
require_relative '../Path'

module WebBlocks
  
  module Build
    
    module Manager
      
      def attach_webblocks
        
        observer ::WebBlocks::Build::WebBlocks.new
        log.success "WebBlocks", "Attached blocks handler"
        
      end
      
      def attach_packages
        
        config[:build][:packages].each do |package|
          
          path = ::WebBlocks::Path.from_root_to "lib/Build/Package/#{package.to_s.downcase.capitalize}.rb"
          
          if File.exists? path
            load path
            begin
              observer(eval("::WebBlocks::Build::Package::#{package.to_s.capitalize}").new)
              log.success "Package", "Attached package handler #{package}"
            rescue
              log.warning "Package", "Skipped package handler #{package} (undefined)"
            end
          else
            log.warning "Package", "Skipped package handler #{package} (undefined)"
          end
          
        end
        
      end
      
      def attach_adapters
        
      end
      
    end
    
  end
  
end