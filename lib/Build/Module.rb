require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
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
          config[:src][:modules] = all_modules
        end
        
        config[:src][:modules] = [config[:src][:modules]] unless config[:src][:modules].is_a?(Array)
        
        config[:src][:modules].map { |mod| mod.downcase } 
        
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
      
      def sass_libs_for base_dir
        
        files = []
        
        get_files(base_dir, 'scss').each do |file|
          files << file if file.match /\/_+variables.scss$/
        end

        get_files(base_dir, 'scss', false).each do |file|
          files << file unless file.match /\/_+variables.scss$/
        end
        
        modules.each do |dir|
          
          subpath = ''
          
          dir.split('/').each do |segment|
            
            subpath << '/' unless subpath.length == 0
            subpath << segment
            path = ::WebBlocks::Path.to base_dir, subpath
            
            next unless path
            
            if File.exists? "#{File.dirname(path)}/_require.scss"
              files << "#{File.dirname(path)}/_require.scss" unless files.include? "#{File.dirname(path)}/_require.scss"
            end
            
            if File.exists? "#{File.dirname(path)}/require.scss"
              files << "#{File.dirname(path)}/require.scss" unless files.include? "#{File.dirname(path)}/require.scss"
            end
            
            if File.exists? "#{path}/_require.scss"
              files << "#{path}/_require.scss" unless files.include? "#{path}/_require.scss"
            end
            
            if File.exists? "#{path}/require.scss"
              files << "#{path}/require.scss" unless files.include? "#{path}/require.scss"
            end
            
            if File.exists? "#{File.dirname(path)}/_require-ie.scss"
              files << "#{File.dirname(path)}/_require-ie.scss" unless files.include? "#{File.dirname(path)}/_require-ie.scss"
            end
            
            if File.exists? "#{File.dirname(path)}/require-ie.scss"
              files << "#{File.dirname(path)}/require-ie.scss" unless files.include? "#{File.dirname(path)}/require-ie.scss"
            end
            
            if File.exists? "#{path}/_require-ie.scss"
              files << "#{path}/_require-ie.scss" unless files.include? "#{path}/_require-ie.scss"
            end
            
            if File.exists? "#{path}/require-ie.scss"
              files << "#{path}/require-ie.scss" unless files.include? "#{path}/require-ie.scss"
            end
            
            if File.exists? "#{path}.scss"
              files << "#{path}.scss" unless files.include? "#{path}.scss"
            end

            if File.exists? "#{File.dirname(path)}/_#{File.basename(path)}.scss"
              files << "#{File.dirname(path)}/_#{File.basename(path)}.scss" unless files.include? "#{File.dirname(path)}/_#{File.basename(path)}.scss"
            end

            if File.exists? "#{path}-ie.scss"
              files << "#{path}-ie.scss" unless files.include? "#{File.dirname(path)}/_#{File.basename(path)}.scss"
            end

            if File.exists? "#{File.dirname(path)}/_#{File.basename(path)}-ie.scss"
              files << "#{File.dirname(path)}/_#{File.basename(path)}-ie.scss"
            end
            
          end
          
          dir = ::WebBlocks::Path.to base_dir, dir
          
          get_files(dir, 'scss').sort.each do |file|
            files << file unless file.match /\/_+variables.scss$/ or file.match /\/_+require.scss$/
          end
          
        end
        
        traversed = []
        if block_given?
          files.each do |file|
            next if traversed.include? file
            yield file 
            traversed << file
          end
        end
        
        files
        
      end
      
      def find_sass_dependencies base_dir
        
        dependencies = []
        
        sass_libs_for base_dir do |file|
          
          File.open file, "r" do |file|
            
            lines = file.grep /^\/\/\!\s*requires\s/
            lines.each do |line|
              line.gsub! /^\/\/\!\s*requires\s*/, ''
              dependencies << line.split(/\s/)
            end
            
          end
          
        end
        
        dependencies.flatten!
        
        normalize_sass_dependencies dependencies
        
      end
      
      def normalize_sass_dependencies dependencies
        
        normalized = []
        
        dependencies.each do |dependency|
          
          already_set = false
          comparison = ''
          
          dependency.split(/\//).each do |segment|
            
            comparison << '/' unless comparison.length == 0
            comparison << segment
            
            already_set = true if normalized.include? comparison
            
          end
          
          normalized << dependency unless already_set
          
        end
        
        normalized
        
      end
      
      def resolve_sass_dependencies base_dir
        
        modules
        
        for depth in 1..50 # TODO: this is a jank way of doing a loop protector
        
          initial = config[:src][:modules].respond_to?(:each) ? config[:src][:modules] : [config[:src][:modules]]
          modules = find_sass_dependencies base_dir

          initial.each do |initial_module|
            
            already_set = false
            comparison = ''

            initial_module.split(/\//).each do |segment|
              comparison << '/' unless comparison.length == 0
              comparison << segment
              already_set = true if modules.include? comparison
            end

            modules << initial_module unless already_set

          end

          # exit if we've stabilized dependencies
          return if config[:src][:modules].to_s == modules.to_s

          # otherwise set config modules and loop again to try to stabilize
          config[:src][:modules] = modules
        
        end
        
        log.warning "Dependencies did not stabilize because of loop"
          
      end
      
      def link_sass_lib file, additionally_to_ie = true
        
        if file.match /\/_+variables.scss$/
          target = tmp_sass_lib_file_variables
        elsif file.match /\/_+require.scss$/
          target = tmp_sass_lib_file_require
        elsif file.match /\/_+require-ie.scss$/
          target = tmp_sass_lib_file_require_ie
        elsif file.match /-ie.scss$/
          target = tmp_sass_lib_file_ie
        else
          target = tmp_sass_lib_file
        end
        
        File.open target, "a" do |handle|
          log.debug "#{File.basename target} <- #{file}"
          handle.puts "@import \"#{file}\";"
        end
        
        if additionally_to_ie and target == tmp_sass_lib_file
          
          target = tmp_sass_lib_file_ie
          File.open target, "a" do |handle|
            log.debug "#{File.basename target} <- #{file}"
            handle.puts "@import \"#{file}\";"
          end
          
        end
        
      end
    
      def link_sass_libs_for base_dir, additionally_to_ie = true
        
        sass_libs_for base_dir do |file|
          link_sass_lib file, additionally_to_ie
        end

      end

      def assemble_font_files_for base_dir

        get_files(base_dir, ['eot','ttf','otf','woff']).each do |file|

          dst = "#{tmp_font_build_dir}/#{file.gsub /^#{base_dir}\//, ''}"
          log.debug "#{tmp_font_build_dir.gsub /^#{root_dir}\//, ''} <- #{file.gsub /^#{root_dir}\//, ''}"
          FileUtils.mkdir_p File.dirname(dst)
          FileUtils.cp_r file, dst

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
          
          next unless dir

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
          
          next unless dir
          
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
        
        [files,ie_files].flatten.each do |file|
          File.open file, "r" do |file|
            lines = file.grep /^\/\/\!\s*requires_package\s/
            lines.each do |line|
              line.gsub! /^\/\/\!\s*requires_package\s*/, ''
              line.split(/\s/).each do |dependency|
                log.warning "Package #{dependency} required and must be included external to WebBlocks" unless config[:build][:packages].include? dependency.to_sym
              end
            end
          end
          
        end
        
      end
      
    end
    
  end
  
end