require 'pathname'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Modernizr < Builder

        def dir_package
          
          generate_dir_package @config[:package][:modernizr][:dir]
          
        end
        
        def build
          
          @log.task "Builder: Modernizr", "Managing Modernizr submodule" do
            manage_submodule 'Modernizr', dir_package
          end
          
          @log.task "Builder: Modernizr", "Packaging Modernizr into Core JS file" do
            if @config[:build][:debug]
              append_contents_to_file "#{dir_package}/modernizr.js", file_build_temp_js
            elsif
              append_compressed_js_to_file "#{dir_package}/modernizr.js", file_build_temp_js
            end
          end
          
        end
        
        def reset
          
          reset_submodule 'Modernizr', dir_package
          
        end
      
      end
      
    end
    
  end
  
end