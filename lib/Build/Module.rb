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
      
      def assemble_img_files_for base_dir
        
        get_files(base_dir, ['gif','jpg','jpeg','png','bmp']).each do |file|
          
          dst = "#{tmp_img_build_dir}/#{file.gsub /^#{base_dir}\//, ''}"
          log.debug "#{tmp_img_build_dir.gsub /^#{root_dir}\//, ''} <- #{file.gsub /^#{root_dir}\//, ''}"
          FileUtils.mkdir_p File.dirname(dst)
          FileUtils.cp_r file, dst
          
        end
        
      end
      
      def assemble_js_libs_into_file_for base_dir, target_absolute_name
        
        puts base_dir
        puts target_absolute_name
        
        files = [[],[]]
        
        get_files(base_dir, 'js').sort.each do |file|

          if file.match /\/_+namespaces.js$/ or file.match /\/_+namespaces\-ie.js$/
            files[0] << file
          end

        end
        
        modules.each do |dir|

          dir = ::WebBlocks::Path.to base_dir, dir

          get_files(dir, 'js').sort.each do |file|

            next if file.match /\/_+namespaces.js$/ or file.match /\/_+namespaces\-ie.js$/

            files[1] << file

          end

        end
        
        files.flatten.each do |file|
          log.debug "#{target_absolute_name.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
          append_file file, target_absolute_name
        end
        
      end
      
      def assemble_js_libs_for base_dir
        
        files = [[],[]]
        ie_files = [[],[]]

        get_files(base_dir, 'js').sort.each do |file|

          if file.match /\/_+namespaces.js$/
            files[0] << file
          elsif file.match /\/_+namespaces\-ie.js$/
            ie_files[0] << file
          end

        end

        modules.each do |dir|

          dir = ::WebBlocks::Path.to base_dir, dir

          get_files(dir, 'js').sort.each do |file|

            next if file.match /\/_+namespaces.js$/ or file.match /\/_+namespaces\-ie.js$/

            if file.match /\-ie.js$/
              ie_files[1] << file
            else
              files[1] << file
            end

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