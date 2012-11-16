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
      
      def link_sass_lib file
        
        if file.match /\/_+variables.scss$/
          target = tmp_sass_lib_file_variables
        elsif file.match /\/_+require.scss$/
          target = tmp_sass_lib_file_require
        elsif file.match /-ie.scss$/
          target = tmp_sass_lib_file_ie
        else
          target = tmp_sass_lib_file
        end
        
        File.open target, "a" do |handle|
          log.debug "#{File.basename target} <- #{file}"
          handle.puts "@import \"#{file}\";"
        end
        
      end
    
      def link_sass_libs_for base_dir

        get_files(base_dir, 'scss').each do |file|
          if file.match /\/_+require.scss$/ or file.match /\/_+variables.scss$/
            link_sass_lib file
          end
        end

        get_files(base_dir, 'scss', false).each do |file|
          unless file.match /\/_+require.scss$/ or file.match /\/_+variables.scss$/ # as already included
            link_sass_lib file
          end
        end
        
        modules.each do |dir|
          
          dir = ::WebBlocks::Path.to base_dir, dir
          
          if File.exists? "#{dir}.scss"
            link_sass_lib "#{dir}.scss"
          end

          if File.exists? "#{File.dirname(dir)}/_#{File.basename(dir)}.scss"
            link_sass_lib "#{File.dirname(dir)}/_#{File.basename(dir)}.scss"
          end

          if File.exists? "#{dir}-ie.scss"
            link_sass_lib "#{dir}-ie.scss"
          end

          if File.exists? "#{File.dirname(dir)}/_#{File.basename(dir)}-ie.scss"
            link_sass_lib "#{File.dirname(dir)}/_#{File.basename(dir)}-ie.scss"
          end
          
          get_files(dir, 'scss').sort.each do |file|

            next if file.match /\/_+variables.scss$/

            link_sass_lib file

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
        
        files = [[],[]]
        
        if File.exists? "#{base_dir}.js"
          files[1] << "#{base_dir}.js"
        end

        if File.exists? "#{File.dirname(base_dir)}/_#{File.basename(base_dir)}.js"
          files[1] << "#{File.dirname(base_dir)}/_#{File.basename(base_dir)}.js"
        end
        
        if File.exists? "#{base_dir}-ie.js"
          files[1] << "#{base_dir}-ie.js"
        end

        if File.exists? "#{File.dirname(base_dir)}/_#{File.basename(base_dir)}-ie.js"
          files[1] << "#{File.dirname(base_dir)}/_#{File.basename(base_dir)}-ie.js"
        end
        
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
          
          if File.exists? "#{dir}.js"
            files[1] << "#{dir}.js"
          end

          if File.exists? "#{File.dirname(dir)}/_#{File.basename(dir)}.js"
            files[1] << "#{File.dirname(dir)}/_#{File.basename(dir)}.js"
          end
          
          if File.exists? "#{dir}-ie.js"
            ie_files[1] << "#{dir}-ie.js"
          end

          if File.exists? "#{File.dirname(dir)}/_#{File.basename(dir)}-ie.js"
            ie_files[1] << "#{File.dirname(dir)}/_#{File.basename(dir)}-ie.js"
          end

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