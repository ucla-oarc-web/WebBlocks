require 'pathname'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Builder < WebBlocks::Build::Builder
        
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