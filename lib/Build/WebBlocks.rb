require 'rubygems'
require 'extensions/kernel'
require 'systemu'
require 'fileutils'
require_relative '../Path.rb'

module WebBlocks
  
  module Build
      
    class WebBlocks
      
      include ::WebBlocks::Path::Source
      include ::WebBlocks::Path::Temporary_Build
      include ::WebBlocks::Path::Build
      
      def preprocess
        
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
        
      end
      
      def clean
        
        FileUtils.rm_rf build_dir
        
      end
      
    end
    
  end
  
end