require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative '../../Path'
require_relative '../Module'
require_relative '../../Logger'

module WebBlocks
  
  module Build
    
    module Core
      
      class Extensions
        
        include ::WebBlocks::Logger
        include ::WebBlocks::Path::Source
        include ::WebBlocks::Build::Module
        
        # TODO: support // @requires in extensions
        
        def link
          
          link_css
          
        end
        
        def link_css
          
          return unless config[:src][:extensions]
          
          extensions = config[:src][:extensions].respond_to?(:each) ? config[:src][:extensions] : [config[:src][:extensions]]
          
          variables_files = ""
          log_variables_files = []
          # Link all SASS files in extension directory
          File.open tmp_sass_lib_file, "a" do |linker|
            File.open tmp_sass_lib_file_ie, "a" do |ie_linker|
              File.open tmp_sass_lib_file_require, "a" do |require_linker|
                File.open tmp_sass_lib_file_require_ie, "a" do |require_ie_linker|
                  
                  extensions.each do |extension|

                    log.task "Core: Extensions", "Linking extension #{extension}" do

                      dir = from_src_extensions_dir_to extension

                      unless dir and File.exists? dir
                        log.failure "Extension #{extension} does not exist"
                      end

                      get_files(dir, 'scss').sort.each do |file|

                        str = "@import \"#{file}\";\n"
                        if file.match /\/_+variables.scss$/
                          variables_files << str
                          log_variables_files.unshift file
                        else
                          if file.match /\/_+require.scss$/
                            target = require_linker
                          elsif file.match /\/_+require-ie.scss$/
                            target = require_ie_linker
                          elsif file.match /-ie.scss$/
                            target = ie_linker
                          else
                            target = linker
                          end
                          target << str
                          log.debug "#{File.basename target.path} <- #{file}"
                        end

                      end

                    end

                  end
                  
                end
              end
            end
          end
          
          current_contents = File.read tmp_sass_lib_file_variables
          File.open tmp_sass_lib_file_variables, "w" do |variables_linker|
            variables_linker << variables_files
            variables_linker << current_contents
              log_variables_files.each do |file|
              log.debug "#{File.basename variables_linker.path} <- #{file}"
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