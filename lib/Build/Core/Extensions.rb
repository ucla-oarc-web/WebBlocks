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
          
          return unless config[:src][:extensions]
          
          extensions = config[:src][:extensions].respond_to?(:each) ? config[:src][:extensions] : [config[:src][:extensions]]
          
          # Link all SASS files in extension directory
          File.open tmp_sass_lib_file, "a" do |linker|
            File.open tmp_sass_lib_file_ie, "a" do |ie_linker|
              File.open tmp_sass_lib_file_require, "a" do |require_linker|
                File.open tmp_sass_lib_file_variables, "a" do |variables_linker|
                  
                  extensions.each do |extension|
                    
                    log.task "Extension", "Linking extension #{extension}" do

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
                        target << "@import \"#{file}\"\n"

                      end
                      
                    end
                    
                  end

                end
              end
            end
          end
          
        end
        
      end
      
    end
    
  end
  
end