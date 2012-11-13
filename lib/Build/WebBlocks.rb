require 'rubygems'
require 'extensions/kernel'
require 'systemu'
require 'fileutils'
require_relative '../Path'
require_relative 'Utilities'

module WebBlocks
  
  module Build
      
    class WebBlocks
      
      include ::WebBlocks::Path::Source
      include ::WebBlocks::Path::Temporary_Build
      include ::WebBlocks::Path::Build
      include ::WebBlocks::Build::Utilities
      
      def preprocess
        
        log.task "WebBlocks", "Set up temporary build directory #{tmp_build_dir}" do
        
          FileUtils.rm_rf tmp_build_dir
          FileUtils.mkdir_p tmp_build_dir
          FileUtils.mkdir_p tmp_css_build_dir
          FileUtils.mkdir_p tmp_img_build_dir
          FileUtils.mkdir_p tmp_js_build_dir
          FileUtils.mkdir_p tmp_js_build_script_dir

          File.open(tmp_css_build_file, "w") {}
          File.open(tmp_css_build_file_ie, "w") {}
          File.open(tmp_js_build_file, "w") {}
          File.open(tmp_js_build_file_ie, "w") {}
          
          FileUtils.mkdir_p tmp_sass_lib_dir
          File.open(tmp_sass_lib_file_variables, "w") {}
          File.open(tmp_sass_lib_file_require, "w") {}
          File.open(tmp_sass_lib_file, "w") do |file|
            file.puts "@import \"#{tmp_sass_lib_file_variables}\";"
            file.puts "@import \"#{tmp_sass_lib_file_require}\";"
          end
          File.open(tmp_sass_lib_file_ie, "w") do |file|
            file.puts "@import \"#{tmp_sass_lib_file_variables}\";"
            #TODO: figure out what to do with this
            #file.puts "@import \"#{tmp_sass_lib_file_require}\";"
          end
        
        end
        
      end
      
      def link
        
        log.task "Core", "Linking source variables files" do
          File.open tmp_sass_lib_file_variables, "a" do |variables_linker|
            get_files(src_sass_dir, 'scss').each do |file|
              next unless file.match /\/_+variables.scss$/
              variables_linker << "@import \"#{file}\";\n"
            end
          end
        end
        
      end
      
      def compile
        
        log.task "WebBlocks", "Run compass compiler" do
          
          success = true
          environment = config[:build][:debug] ? "development" : "production"
          
          Dir.chdir tmp_build_dir do
            
            status, stdout, stderr = systemu "#{config[:exec][:compass]} compile -e #{environment} --boring --sass-dir #{src_sass_dir} --config \"#{src_core_compass_config_file}\""
            
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
      
      def package # TODO add minification
        
        log.task "WebBlocks", "Packaging build files into #{build_dir}" do
        
          log.info "Creating build directories" do
            FileUtils.mkdir_p build_dir
            FileUtils.mkdir_p css_build_dir
            FileUtils.mkdir_p img_build_dir
            FileUtils.mkdir_p js_build_dir
          end
          
          log.info "Copying #{tmp_css_build_file} to #{css_build_file}" do
            FileUtils.cp tmp_css_build_file, css_build_file
          end
          
          log.info "Copying #{tmp_css_build_file_ie} to #{css_build_file_ie}" do
            FileUtils.cp tmp_css_build_file_ie, css_build_file_ie
          end
          
          log.info "Copying #{tmp_img_build_dir} to #{img_build_dir}" do
            FileUtils.rm_rf img_build_dir
            FileUtils.cp_r tmp_img_build_dir, img_build_dir
          end
          
          log.info "Copying #{tmp_js_build_file} to #{js_build_file}" do
            FileUtils.cp tmp_js_build_file, js_build_file
          end
          
          log.info "Copying #{tmp_js_build_file_ie} to #{js_build_file_ie}" do
            FileUtils.cp tmp_js_build_file_ie, js_build_file_ie
          end
          
          log.info "Copying #{tmp_js_build_script_dir} to #{js_build_script_dir}" do
            FileUtils.rm_rf js_build_script_dir
            FileUtils.cp_r tmp_js_build_script_dir, js_build_script_dir
          end
          
        end
        
      end
      
      def clean
        
        FileUtils.rm_rf build_dir
        
      end
      
    end
    
  end
  
end