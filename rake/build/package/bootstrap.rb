require 'pathname'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Bootstrap < Builder
        
        def dir_package
          generate_dir_package @config[:package][:bootstrap][:dir]
        end
        
        def build
          
          @log.task "Builder: Bootstrap", "Managing Bootstrap submodule" do
            updated = manage_submodule 'Bootstrap', dir_package
          end
          
          @log.task "Builder: Bootstrap", "Packaging Bootstrap Javascript into Core JS file" do
            @config[:package][:bootstrap][:scripts].each do |script|
              src = "#{dir_package}/js/bootstrap-#{script}.js"
              @log.info "bootstrap-#{script}.js"
              if @config[:build][:debug]
                append_contents_to_file src, file_build_temp_js
              elsif
                append_compressed_js_to_file src, file_build_temp_js
              end
            end
          end
          
          @log.task "Builder: Bootstrap", "Packaging Bootstrap images into images directory" do
            base_dir = "#{dir_package}/img"
            WebBlocks::Util.get_files(base_dir).each do |src|
              name = src.sub /^#{base_dir}\//, ''
              @log.debug name
              dst = "#{dir_build_temp_img}/#{name}"
              FileUtils.mkdir_p File.dirname(dst)
              FileUtils.cp src, dst
            end
          end
          
        end
        
        # Deletes the submodule
        def reset
          reset_submodule 'Bootstrap', dir_package
        end

      end
    
    end
    
  end
  
end