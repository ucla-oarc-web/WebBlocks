require 'rubygems'
require 'extensions/kernel'
require_relative '../../Path'
require_relative '../Module'

module WebBlocks
  
  module Build
    
    module Core
      
      class Extensions
        
        include ::WebBlocks::Path::Source
        include ::WebBlocks::Build::Module
        
        def link
          
          link_css
          
        end
        
        def link_css
          
          return unless config[:src][:extensions]
          
          extensions = config[:src][:extensions].respond_to?(:each) ? config[:src][:extensions] : [config[:src][:extensions]]
          
          # Link all SASS files in extension directory
          File.open tmp_sass_lib_file, "a" do |linker|
            File.open tmp_sass_lib_file_ie, "a" do |ie_linker|
              File.open tmp_sass_lib_file_require, "a" do |require_linker|
                File.open tmp_sass_lib_file_variables, "a" do |variables_linker|
                  
                  extensions.each do |extension|
                    
                    log.task "Core: Extensions", "Linking extension #{extension}" do

                      dir = from_src_extensions_dir_to extension

                      get_files(dir, 'scss').sort.each do |file|

                        if file.match /\/_+variables.scss$/
                          target = variables_linker
                        elsif file.match /\/_+require.scss$/
                          target = require_linker
                        elsif file.match /-ie.scss$/
                          target = ie_linker
                        else
                          target = linker
                        end
                        

                        log.debug "#{File.basename target.path} <- #{file}"
                        target << "@import \"#{file}\";\n"

                      end
                      
                    end
                    
                  end

                end
              end
            end
          end
          
        end
        
        def assemble
          
          assemble_img
          assemble_js
          
        end
        
        def assemble_img
          
          return unless config[:src][:extensions]
          extensions = config[:src][:extensions].respond_to?(:each) ? config[:src][:extensions] : [config[:src][:extensions]]
          
          extensions.each do |extension|
            
            log.task "Core: Extensions", "Copying JS from extension #{extension}" do
              assemble_img_files_for from_src_extensions_dir_to extension
            end
            
          end
          
        end
        
        def assemble_js
          
          return unless config[:src][:extensions]
          extensions = config[:src][:extensions].respond_to?(:each) ? config[:src][:extensions] : [config[:src][:extensions]]
          
          extensions.each do |extension|
            
            log.task "Core: Extensions", "Copying JS from extension #{extension}" do
          
              base_dir = from_src_extensions_dir_to extension

              files = [[],[]]
              ie_files = [[],[]]

              get_files(base_dir, 'js').sort.each do |file|

                if file.match /\/_+namespaces.js$/
                  files[0] << file
                elsif file.match /\/_+namespaces\-ie.js$/
                  ie_files[0] << file
                elsif file.match /\-ie.js$/
                  ie_files[1] << file
                else
                  files[1] << file
                end

              end

              files.flatten.each do |file|
                log.debug "#{tmp_js_build_file.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
                append_file file, tmp_js_build_file
              end

              ie_files.flatten.each do |file|
                log.debug "#{tmp_js_build_file_ie.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
                append_file file, tmp_js_build_file_ie
              end
            
            end

          end
        
        end
        
      end
      
    end
    
  end
  
end