require 'pathname'
require 'systemu'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Builder < WebBlocks::Build::Builder
        
        def manage_submodule module_name, module_path
          
          @log.debug "Builder: Package", "Invoking #{@config[:exec][:git]} submodule init #{module_path}"
          status, stdout, stderr = systemu "#{@config[:exec][:git]} submodule init #{module_path}"
          @log.info "Builder: Package", "Initialized #{module_name} submodule" if stdout.length > 0
          
          @log.debug "Builder: Package", "Invoking #{@config[:exec][:git]} submodule update #{module_path}"
          status, stdout, stderr = systemu "#{@config[:exec][:git]} submodule update #{module_path}"
          @log.info "Builder: Package", "Updated #{module_name} submodule" if stdout.length > 0
          
          stdout.length > 0
          
        end
        
        def reset_submodule module_name, module_path
          
          if File.exists? "#{module_path}"
            @log.task "Builder: Package", "Removing checkout of #{module_name} submodule" do
              FileUtils.rm_rf "#{module_path}"
            end
            true
          else
            false
          end
          
        end
        
        def dir_packages
          @config[:package][:dir]
        end
        
        def generate_dir_package name
          WebBlocks::Util.file_from_root_through_dir_stack self.dir_packages, name
        end

      end
    
    end
    
  end
  
end