require 'pathname'
require 'systemu'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Jquery < Builder

        def dir_package
          generate_dir_package @config[:package][:jquery][:dir]
        end
        
        # Updates the submodule and recompiles if needed. Then it packages the
        # jQuery build file into the temporary JS build directory.
        def build
          
          puts ".. Managing jQuery submodule"
          
          updated = manage_submodule 'jQuery', dir_package
          
          rebuild = updated or !(File.exist? "#{dir_package}/dist")
          
          compile if rebuild
          
          puts ".. Packaging jQuery into Core JS file"
          
          filename = @config[:build][:debug] ? "jquery.js" : "jquery.min.js"
          append_contents_to_file "#{dir_package}/dist/#{filename}", file_build_temp_js
          
          
        end
        
        # Uses NPM to fetch dependencies and then Grunt to compile jQuery into
        # the /dist folder within the submodule.
        def compile
          Dir.chdir dir_package do
            puts ".. Fetching dependencies"
            fail "[ERROR] NPM execution failed" unless systemu "#{@config[:exec][:npm]} install"
            puts ".. Compiling jQuery"
            fail "[ERROR] Grunt execution failed" unless systemu "#{@config[:exec][:grunt]}"
          end
        end
        
        # Removes the dist directory where the Grunt compile places the built
        # jQuery script.
        def clean
          if File.exists? "#{dir_package}/dist"
            puts ".. Removing jQuery dist directory"
            FileUtils.rm_rf "#{dir_package}/dist"
          end
        end
        
        # Deletes the submodule
        def reset
          reset_submodule 'jQuery', dir_package
        end
      
      end
      
    end
    
  end
  
end