require 'pathname'
require 'systemu'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Builder < WebBlocks::Build::Builder
        
        def manage_submodule module_name, module_path
          
          status, stdout, stderr = systemu "#{@config[:exec][:git]} submodule init #{module_path}"
          puts ".. Initialized #{module_name} submodule" if stdout.length > 0
          
          status, stdout, stderr = systemu "#{@config[:exec][:git]} submodule update #{module_path}"
          puts ".. Updated #{module_name} submodule" if stdout.length > 0
          
          stdout.length > 0
          
        end
        
        def reset_submodule module_name, module_path
          
          if File.exists? "#{module_path}"
            puts ".. Removing checkout of #{module_name} submodule"
            FileUtils.rm_rf "#{module_path}"
            true
          else
            false
          end
          
        end
        
        def dir_packages
          @config[:package][:dir]
        end
        
        def generate_dir_package name
          dir_root = Pathname.new(Dir.pwd)
          dir_package = WebBlocks::Util.file_from_dir_stack self.dir_packages, name
          Pathname.new(dir_package).relative_path_from(dir_root);
        end

      end
    
    end
    
  end
  
end