require 'pathname'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Selectivizr < Builder

        def dir_package
          
          generate_dir_package @config[:package][:selectivizr][:dir]
          
        end
        
        def build
          
          @log.task "Builder: Selectivizr", "Managing Selectivizr submodule" do
            manage_submodule 'Selectivizr', dir_package
          end
          
          @log.task "Builder: Selectivizr", "Packaging Selectivizr into IE JS file" do
            if @config[:build][:debug]
              append_contents_to_file "#{dir_package}/selectivizr.js", file_build_temp_js_ie
            elsif
              append_compressed_js_to_file "#{dir_package}/selectivizr.js", file_build_temp_js_ie
            end
          end
          
        end
        
        def reset
          
          reset_submodule 'Selectivizr', dir_package
          
        end
      
      end
      
    end
    
  end
  
end