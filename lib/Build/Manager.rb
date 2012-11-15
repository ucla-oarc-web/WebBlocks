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
      
      def attach_module namespace, mod
        
        mod = mod.to_s.downcase.capitalize
        
        path = ::WebBlocks::Path.from_root_to "lib/Build/#{namespace}/#{mod}.rb"
        if File.exists? path
          load path
          begin
            observer(eval("::WebBlocks::Build::#{namespace.capitalize}::#{mod}").new)
            log.success namespace.capitalize, "Attached #{namespace} handler #{mod}"
          rescue
            log.warning namespace.capitalize, "Skipped #{namespace} handler #{mod} (undefined)"
          end
        else
          log.warning namespace.capitalize, "Skipped #{namespace} handler #{mod} (undefined)"
        end
        
      end
      
      def attach_core mod
          
        attach_module 'core', mod
        
      end
      
      def attach_adapter adapter
        
        attach_module 'adapter', adapter
        
      end
      
      def attach_adapters
        
        adapters = []
        
        if config[:src][:adapter]
          adapters = config[:src][:adapter].respond_to?(:each) ? config[:src][:adapter] : [config[:src][:adapter]]
        end
        
        attach_core 'adapter'
        
        adapters.each do |adapter|
          
          attach_adapter adapter
          
        end
        
        attach_core 'extensions'
        attach_core 'definitions'
        
      end
      
    end
    
  end
  
end