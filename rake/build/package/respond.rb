require 'pathname'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Respond < Builder

        def dir_package
          
          generate_dir_package @config[:package][:respond][:dir]
          
        end
        
        def build
          
          @log.task "Builder: Respond.js", "Managing Respond.js submodule" do
            manage_submodule 'Respond.js', dir_package
          end
          
          @log.task "Builder: Respond.js", "Packaging Respond.js into IE JS file" do
            if @config[:build][:debug]
              append_contents_to_file "#{dir_package}/respond.src.js", file_build_temp_js_ie
            elsif
              append_contents_to_file "#{dir_package}/respond.min.js", file_build_temp_js_ie
            end
          end
          
        end
        
        def reset
          
          reset_submodule 'Respond.js', dir_package
          
        end
      
      end
      
    end
    
  end
  
end