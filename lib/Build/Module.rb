require 'rubygems'
require 'extensions/kernel'
require_relative '../Path'
require_relative 'Utilities'

module WebBlocks
  
  module Build
    
    module Module
      
      include ::WebBlocks::Path::Source
      include ::WebBlocks::Path::Temporary_Build
      include ::WebBlocks::Build::Utilities
      
      def modules
        
        if config[:src][:modules] == :all
          all_modules
        elsif config[:src][:modules]
          config[:src][:modules].respond_to?(:each) ? config[:src][:modules] : [config[:src][:modules]]
        else
          []
        end
        
      end
      
      def all_modules
        
        modules = []
        dir = src_core_definitions_dir
        Dir.entries(dir).sort.each do |name|
          next if name[0,1] == '.'
          if File.directory? "#{dir}/#{name}"
            modules.push name
          end
        end
        modules
        
      end
    
      def link_sass_libs_for base_dir

        File.open tmp_sass_lib_file, "a" do |linker|
          File.open tmp_sass_lib_file_ie, "a" do |ie_linker|
            File.open tmp_sass_lib_file_require, "a" do |require_linker|

              # Pull _require.scss file from root (special file)
              get_files(base_dir, 'scss', false).sort.each do |file|
                
                next unless file.match /\/_+require.scss$/
                
                log.debug "#{File.basename require_linker.path} <- #{file}"
                require_linker << "@import \"#{file}\"\n"
                
              end
              
              # For all modules, link files as standard, IE and require
              modules.each do |dir|

                dir = ::WebBlocks::Path.to base_dir, dir

                get_files(dir, 'scss').sort.each do |file|

                  next if file.match /\/_+variables.scss$/

                  if file.match /\/_+require.scss$/
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

        # Link all variables files
        File.open tmp_sass_lib_file_variables, "a" do |variables_linker|

          get_files(base_dir, 'scss').each do |file|
            next unless file.match /\/_+variables.scss$/
            variables_linker << "@import \"#{file}\";\n"
          end

        end

      end
      
    end
    
  end
  
end