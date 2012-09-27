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
          
          @log.task "Builder: jQuery", "Managing jQuery submodule" do
            updated = manage_submodule 'jQuery', dir_package
            rebuild = updated or !(File.exist? "#{dir_package}/dist")
            if rebuild
              @log.task "Builder: jQuery", "Building jQuery submodule" do
                compile
              end
            end
          end
          
          log.task "Builder: jQuery", ".. Packaging jQuery into Core JS file" do
            filename = @config[:build][:debug] ? "jquery.js" : "jquery.min.js"
            append_contents_to_file "#{dir_package}/dist/#{filename}", file_build_temp_js
          end
          
          
        end
        
        # Uses NPM to fetch dependencies and then Grunt to compile jQuery into
        # the /dist folder within the submodule.
        def compile
          Dir.chdir dir_package do
            @log.task "Builder: jQuery", "Executing NPM to fetch jQuery dependencies" do
              @log.failure "Builder: jQuery", "NPM execution failed" unless systemu "#{@config[:exec][:npm]} install"
            end
            @log.task "Builder: jQuery", "Executing Grunt to build jQuery" do
              @log.failure "Builder: jQuery", "Grunt execution failed" unless systemu "#{@config[:exec][:grunt]}"
            end
          end
        end
        
        # Removes the dist directory where the Grunt compile places the built
        # jQuery script.
        def clean
          if File.exists? "#{dir_package}/dist"
            @log.task "Builder: jQuery", "Removing jQuery dist directory" do
              FileUtils.rm_rf "#{dir_package}/dist"
            end
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