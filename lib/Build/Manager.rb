require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
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
        
        (config[:src][:packages] | config[:build][:packages]).each do |package|
          
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
        
        mod = mod.to_s.downcase
        namespace = namespace.to_s.downcase

        if config[:src][:search].has_key?(namespace.to_sym) and config[:src][:search][namespace.to_sym].has_key?(mod)
          search = config[:src][:search][namespace.to_sym][mod]
        else
          search = nil
        end

        mod = mod.capitalize
        namespace = namespace.capitalize

        if search and search.has_key?(:path)
          path = search[:path]
        else
          path = ::WebBlocks::Path.from_root_to "lib/Build/#{namespace}/#{mod}.rb"
        end

        if search and search.has_key?(:class)
          klass = search[:class][0,2] == '::' ? search[:class] : "::#{search[:class]}"
        else
          klass = "::WebBlocks::Build::#{namespace}::#{mod}"
        end

        if File.exists? path
          load path
          begin
            observer(eval(klass).new)
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