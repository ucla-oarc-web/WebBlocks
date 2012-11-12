require 'rubygems'
require 'extensions/kernel'
require 'systemu'
require 'fileutils'
require_relative '../Path.rb'

module WebBlocks
  
  module Build
    
    module Package
      
      include ::WebBlocks::Path::Source
      
      def init_submodule name
        
        stdout = ""
        
        log.task "Package", "Initializing submodule #{name}" do
        
          status, stdout, stderr = systemu "#{config[:exec][:git]} submodule init #{package_dir name}"

          if stderr.length > 0
            log.failure "Package: #{name}", "Initialization failed for submodule #{name}"
          elsif stdout.length > 0
            log.success "Package: #{name}", "Initialized submodule #{name}"
          else
            log.info "Package: #{name}", "Skipped as submodule #{name} is already initialized"
          end
        
        end

        stdout.length > 0
        
      end
      
      def update_submodule name
        
        stdout = ""
        
        log.task "Package", "Updating submodule #{name}" do
        
          status, stdout, stderr = systemu "#{config[:exec][:git]} submodule update #{package_dir name}"

          if stderr.length > 0
            log.failure "Package: #{name}", "Update failed for submodule #{name}"
          elsif stdout.length > 0
            log.success "Package: #{name}", "Updated submodule #{name}"
          else
            log.info "Package: #{name}", "Skipped as submodule #{name} is already up to date"
          end
        
        end

        stdout.length > 0
        
      end
      
      def preprocess_submodule name

        init_submodule name
        update_submodule name
          
      end
      
      def reset_submodule name
        
        if File.exists? "#{package_dir name}"
          
          log.task "Package", "Removing checkout of #{name}" do
            FileUtils.rm_rf package_dir name
          end
          
          true
          
        else
          
          false
          
        end

      end
      
    end
    
  end
  
end