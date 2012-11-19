require 'rubygems'
require 'extensions/kernel'
require 'systemu'
require 'fileutils'
require_relative '../Path.rb'

module WebBlocks
  
  module Build
    
    module Submodule
      
      include ::WebBlocks::Path::Source
      
      def init_submodule name
        
        stdout = ""
        
        log.task "Submodule", "Initializing submodule #{name}" do
        
          status, stdout, stderr = systemu "#{config[:exec][:git]} submodule init #{package_dir name}"

          if stderr.length > 0
            log.failure "Submodule: #{name}", "Initialization failed for submodule #{name}"
          elsif stdout.length > 0
            log.success "Submodule: #{name}", "Initialized submodule #{name}"
          else
            log.info "Submodule: #{name}", "Skipped as submodule #{name} is already initialized"
          end
        
        end

        stdout.length > 0
        
      end
      
      def init_submodule_submodules name
        
        stdout = ""
        
        log.task "Submodule", "Updating submodules of submodule #{name}" do
        
          Dir.chdir(package_dir name) do
          
            status, stdout, stderr = systemu "#{config[:exec][:git]} submodule update"

            if stderr.length > 0
              log.failure "Submodule: #{name}", "Update failed for submodules of submodule #{name}"
            else
              log.success "Submodule: #{name}", "Updated submodules of submodule #{name}"
            end
          
          end
        
        end

        stdout.length > 0
        
      end
      
      def update_submodule name
        
        stdout = ""
        
        log.task "Submodule", "Updating submodule #{name}" do
        
          status, stdout, stderr = systemu "#{config[:exec][:git]} submodule update #{package_dir name}"

          if stderr.length > 0
            log.failure "Submodule: #{name}", "Update failed for submodule #{name}"
          elsif stdout.length > 0
            log.success "Submodule: #{name}", "Updated submodule #{name}"
          else
            log.info "Submodule: #{name}", "Skipped as submodule #{name} is already up to date"
          end
        
        end

        stdout.length > 0
        
      end
      
      def update_submodule_submodules name
        
        stdout = ""
        
        log.task "Submodule", "Updating submodules of submodule #{name}" do
        
          Dir.chdir(package_dir name) do
          
            status, stdout, stderr = systemu "#{config[:exec][:git]} submodule update"

            if stderr.length > 0
              log.failure "Submodule: #{name}", "Update failed for submodules of submodule #{name}"
            else
              log.success "Submodule: #{name}", "Updated submodules of submodule #{name}"
            end
          
          end
        
        end

        stdout.length > 0
        
      end
      
      def preprocess_submodule name

        init_submodule name
        update_submodule name
          
      end
      
      def preprocess_submodule_submodules name
        
        init_submodule_submodules name
        update_submodule_submodules name
        
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