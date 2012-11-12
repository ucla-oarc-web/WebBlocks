require 'rubygems'
require 'extensions/kernel'
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
      
      def attach_adapter adapter
        
        path = ::WebBlocks::Path.from_root_to "lib/Build/Adapter/#{adapter.to_s.downcase.capitalize}.rb"
        if File.exists? path
          load path
          begin
            observer(eval("::WebBlocks::Build::Adapter::#{adapter.to_s.capitalize}").new)
            log.success "Adapter", "Attached adapter handler #{adapter}"
          rescue
            log.warning "Adapter", "Skipped adapter handler #{adapter} (undefined)"
          end
        else
          log.warning "Adapter", "Skipped adapter handler #{adapter} (undefined)"
        end
        
      end
      
      def attach_adapters
        
        adapters = []
        
        if config[:src][:adapter]
          adapters = config[:src][:adapter].respond_to?(:each) ? config[:src][:adapter] : [config[:src][:adapter]]
        end
        
        attach_adapter 'core'
        
        adapters.each do |adapter|
          
          next if adapter == 'core' # as already loaded
          
          attach_adapter adapter
          
        end
        
      end
      
    end
    
  end
  
end