require 'pathname'
require 'systemu'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Jquery < Builder

        def dir_package
          
          dir_root = Pathname.new(Dir.pwd)
          dir_package = WebBlocks::Util.dir_from_dir_stack self.dir_packages, @config[:package][:jquery][:dir]
          Pathname.new(dir_package).relative_path_from(dir_root);
          
        end
        
        def build
          
          status, stdout, stderr = systemu "#{@config[:exec][:git]} submodule --init --recursive update #{dir_package}"
          rebuild = ((stdout.length > 0) or !(File.exist? "#{dir_package}/dist"))
          
          compile if rebuild
          
          puts ".. Packaging jQuery"
          # TODO
          
        end
        
        def rebuild
          
          puts ".. Rebuilding jQuery"
          compile
          build
          
        end
        
        def compile
          
          Dir.chdir dir_package do
            
            puts ".. Fetching dependencies"
            fail "[ERROR] NPM execution failed" unless systemu "#{@config[:exec][:npm]} install"
          
            puts ".. Compiling jQuery"
            fail "[ERROR] Grunt execution failed" unless systemu "#{@config[:exec][:grunt]}"
            
          end
          
        end
        
        def clean
          
          puts ".. Removing jQuery dist directory"
          FileUtils.rm_rf "#{dir_package}/dist"
          
        end
      
      end
      
    end
    
  end
  
end