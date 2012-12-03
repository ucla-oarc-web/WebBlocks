require 'rubygems'
require 'extensions/kernel'
require 'systemu'
require 'fileutils'
require_relative '../Path'
require_relative 'Utilities'
require_relative '../Logger'

module WebBlocks
  
  module Build
      
    class WebBlocks
      
      include ::WebBlocks::Logger
      include ::WebBlocks::Path::Source
      include ::WebBlocks::Path::Temporary_Build
      include ::WebBlocks::Path::Build
      include ::WebBlocks::Build::Utilities
      
      def init
        
        log.task "WebBlocks", "Initializing WebBlocks metadata" do
          FileUtils.mkdir "#{root_dir}/.blocks" unless File.exists? "#{root_dir}/.blocks"
        end
        
      end
      
      def preprocess
        
        log.task "WebBlocks", "Set up temporary build directory" do
        
          preprocess_css
          preprocess_img
          preprocess_js
        
        end
        
      end
      
      def preprocess_css
        
        log.task "WebBlocks", "Set up CSS temporary build region" do
        
          FileUtils.mkdir_p tmp_build_dir
          FileUtils.rm_rf tmp_css_build_dir
          FileUtils.mkdir_p tmp_css_build_dir

          File.open(tmp_css_build_file, "w") {}
          File.open(tmp_css_build_file_ie, "w") {}
          
          FileUtils.mkdir_p tmp_sass_lib_dir
          File.open(tmp_sass_lib_file_variables, "w") {}
          File.open(tmp_sass_lib_file_require, "w") {}
          File.open(tmp_sass_lib_file, "w") do |file|
            file.puts "@import \"#{tmp_sass_lib_file_variables}\";"
            file.puts "@import \"#{tmp_sass_lib_file_require}\";"
          end
          File.open(tmp_sass_lib_file_ie, "w") do |file|
            file.puts "@import \"#{tmp_sass_lib_file_variables}\";"
          end
        
        end
        
      end
      
      def preprocess_img
        
        log.task "WebBlocks", "Set up image temporary build region" do
        
          FileUtils.mkdir_p tmp_build_dir
          FileUtils.rm_rf tmp_img_build_dir
          FileUtils.mkdir_p tmp_img_build_dir
        
        end
        
      end
      
      def preprocess_js
        
        log.task "WebBlocks", "Set up JS temporary build region" do
        
          FileUtils.mkdir_p tmp_build_dir
          FileUtils.rm_rf tmp_js_build_dir
          FileUtils.mkdir_p tmp_js_build_dir
          FileUtils.mkdir_p tmp_js_build_script_dir
          
          File.open(tmp_js_build_file, "w") {}
          File.open(tmp_js_build_file_ie, "w") {}
          
        end
        
      end
      
      def link
        
        link_css
        
      end
      
      def link_css
        
        log.task "WebBlocks", "Linking source variables files" do
          File.open tmp_sass_lib_file_variables, "a" do |variables_linker|
            get_files(src_sass_dir, 'scss').each do |file|
              next unless file.match /\/_+variables.scss$/
              variables_linker << "@import \"#{file}\";\n"
            end
          end
        end
        
      end
      
      def compile
        
        compile_css
        
      end
      
      def compile_css
        
        log.task "WebBlocks", "Run Compass compiler" do
          
          success = true
          environment = config[:build][:debug] ? "development" : "production"
          
          Dir.chdir tmp_build_dir do
            
            status, stdout, stderr = systemu "#{config[:exec][:compass]} compile -e #{environment} --boring --sass-dir \"#{src_sass_dir}\" --config \"#{src_core_compass_config_file}\""
            
            success = false if status != 0
            if success
              log.debug stdout
            else
              log.failure "Compiler", "Compass compile error: \n#{stdout}\n#{stderr}"
            end
            
            # remove SASS includes directory if within compile directory
            if src_sass_includes_dir and src_sass_includes_dir.match /^#{src_sass_dir}\//
              relname = src_sass_includes_dir.sub /^#{src_sass_dir}\//, ''
              FileUtils.rm_rf "#{tmp_css_build_dir}/compiled/#{relname}"
            end
            
          end
          
        end
        
      end
      
      def assemble
        
        assemble_css
        assemble_img
        assemble_js
        
      end
      
      def assemble_css
        
        log.task "WebBlocks", "Assembling compiled sources into CSS files" do
          
          dir = "#{tmp_css_build_dir}/compiled"
          
          get_files(dir, 'css').each do |src|
            dst = src.match(/\-ie.css$/) ? tmp_css_build_file_ie : tmp_css_build_file
            log.debug "#{dst.gsub /^#{root_dir}\//, ''} <<- #{src.gsub /^#{root_dir}\//, ''}"
            append_file src, dst
          end
          
        end
        
        log.task "WebBlocks", "Assembling CSS sources into CSS files" do
          
          dir = src_css_dir
          
          get_files(dir, 'css').each do |src|
            dst = src.match(/\-ie.css$/) ? tmp_css_build_file_ie : tmp_css_build_file
            log.debug "#{dst.gsub /^#{root_dir}\//, ''} <<- #{src.gsub /^#{root_dir}\//, ''}"
            append_file src, dst
          end
          
        end
        
      end
      
      def assemble_img
        
        log.task "WebBlocks", "Assembling image sources into JS files" do
          
          dir = src_img_dir
          
          get_files(dir, ['gif','jpg','jpeg','png','bmp']).each do |src|
            relname = src.gsub /^#{dir}\//, ''
            dst = "#{tmp_img_build_dir}/#{relname}"
            log.debug "#{tmp_img_build_dir.gsub /^#{root_dir}\//, ''} <- #{src.gsub /^#{root_dir}\//, ''}"
            FileUtils.mkdir_p File.dirname(dst)
            FileUtils.cp src, dst
          end
          
        end
        
      end
      
      def assemble_js
        
        log.task "WebBlocks", "Assembling JS core sources into JS files" do
          
          dir = src_js_core_dir
          
          get_files(dir, 'js').each do |src|
            dst = tmp_js_build_file
            log.debug "#{dst.gsub /^#{root_dir}\//, ''} <<- #{src.gsub /^#{root_dir}\//, ''}"
            append_file src, dst
          end
          
        end
        
        log.task "WebBlocks", "Assembling JS core-ie sources into JS files" do
          
          dir = src_js_core_ie_dir
          
          get_files(dir, 'js').each do |src|
            dst = tmp_js_build_file_ie
            log.debug "#{dst.gsub /^#{root_dir}\//, ''} <<- #{src.gsub /^#{root_dir}\//, ''}"
            append_file src, dst
          end
          
        end
        
        log.task "WebBlocks", "Assembling JS script sources into JS scripts dir" do
          
          dir = src_js_script_dir
          
          get_files(dir, 'js').each do |src|
            relname = src.gsub /^#{dir}\//, ''
            dst = "#{tmp_js_build_script_dir}/#{relname}"
            log.debug "#{tmp_js_build_script_dir.gsub /^#{root_dir}\//, ''} <- #{src.gsub /^#{root_dir}\//, ''}"
            FileUtils.mkdir_p File.dirname(dst)
            FileUtils.cp src, dst
          end
          
        end
        
      end
      
      def package
        
        log.task "WebBlocks", "Packaging build files" do
        
          package_css
          package_img
          package_js
          
        end
        
      end
      
      def package_css
        
        FileUtils.mkdir_p build_dir
        FileUtils.mkdir_p css_build_dir
        
        log.task "WebBlocks", "Packaging CSS build files" do
          
          log.info "Copying #{tmp_css_build_file} to #{css_build_file}" do
            if config[:build][:debug]
              FileUtils.cp tmp_css_build_file, css_build_file
            else
              Append.compressed_css_file tmp_css_build_file, css_build_file
            end
          end
          
          log.info "Copying #{tmp_css_build_file_ie} to #{css_build_file_ie}" do
            if config[:build][:debug]
              FileUtils.cp tmp_css_build_file_ie, css_build_file_ie
            else
              Append.compressed_css_file tmp_css_build_file_ie, css_build_file_ie
            end
          end
          
        end
        
      end
      
      def package_img
        
        FileUtils.mkdir_p build_dir
        FileUtils.mkdir_p img_build_dir
        
        log.task "WebBlocks", "Packaging image build files" do
          
          log.info "Copying #{tmp_img_build_dir} to #{img_build_dir}" do
            FileUtils.rm_rf img_build_dir
            FileUtils.cp_r tmp_img_build_dir, img_build_dir
          end
          
        end
        
      end
      
      def package_js
        
        FileUtils.mkdir_p build_dir
        FileUtils.mkdir_p js_build_dir
        
        log.task "WebBlocks", "Packaging JS build files" do
          
          log.info "Copying #{tmp_js_build_file} to #{js_build_file}" do
            if config[:build][:debug]
              FileUtils.cp tmp_js_build_file, js_build_file
            else
              log.failure "Compression error encountered in #{tmp_js_build_file}" unless Append.compressed_js_file tmp_js_build_file, js_build_file
            end
          end
          
          log.info "Copying #{tmp_js_build_file_ie} to #{js_build_file_ie}" do
            if config[:build][:debug]
              FileUtils.cp tmp_js_build_file_ie, js_build_file_ie
            else
              log.failure "Compression error encountered in #{tmp_js_build_file_ie}" unless Append.compressed_js_file tmp_js_build_file_ie, js_build_file_ie
            end
          end
          
          log.info "Copying #{tmp_js_build_script_dir} to #{js_build_script_dir}" do
            
            FileUtils.rm_rf js_build_script_dir
            
            if config[:build][:debug]
              FileUtils.cp_r tmp_js_build_script_dir, js_build_script_dir
            else
              get_files(tmp_js_build_script_dir).each do |src|
                dst = "#{js_build_script_dir}/#{src.gsub /^#{tmp_js_build_script_dir}\//, ''}"
                FileUtils.mkdir_p File.dirname dst
                log.failure "Compression error encountered in #{src}" unless Append.compressed_js_file src, dst
              end
            end
            
          end
          
        end
        
      end
      
      def clean
        
        log.task "WebBlocks", "Removing build directory" do
          FileUtils.rm_rf build_dir
        end
        
      end
      
      def reset
        
        log.task "WebBlocks", "Removing WebBlocks metadata" do
          FileUtils.rm_rf "#{root_dir}/.blocks"
        end
        
      end
      
      module Append
        
        extend ::WebBlocks::Config

        def self.compressed_css_file src, dst
          status, stdout, stderr = systemu "#{config[:exec][:uglifycss]} \"#{src}\" > \"#{dst}\""
          status == 0
        end

        def self.compressed_js_file src, dst
          status, stdout, stderr = systemu "#{config[:exec][:uglifyjs]} --unsafe \"#{src}\" > \"#{dst}\""
          status == 0
        end
      
      end
      
    end
    
  end
  
end