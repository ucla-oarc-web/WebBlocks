require 'fileutils'
require 'pathname'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"

module WebBlocks
  
  module Build
    
    class Blocks < Builder
      
      def init
        
        puts ".. Defining WebBlocks metadata"
        FileUtils.mkdir_p dir_build_metadata unless init?
        
      end
      
      def init?
        
        File.exists? dir_build_metadata
        
      end
      
      def reset
        
        puts ".. Resetting WebBlocks to initial state"
        FileUtils.rm_rf dir_build_metadata
        
      end
      
      def build_setup
        
        fail "[ERROR] Temporary build directory already exists [run `rake clean` to resolve]" if File.exists? dir_build_temp
        puts ".. Setting up temporary region for build"
        
        FileUtils.mkdir_p dir_build_temp 
        FileUtils.touch file_build_temp_css
        FileUtils.touch file_build_temp_css_ie
        FileUtils.touch file_build_temp_js
        FileUtils.touch file_build_temp_js_ie
        FileUtils.mkdir_p dir_build_temp_js
        FileUtils.mkdir_p dir_build_temp_img
        
      end
      
      def build
        
        puts ".. Copying build from temporary region into build targets"
        
        FileUtils.mkdir_p @config[:build][:dir] unless File.exists? @config[:build][:dir]
        Dir.chdir @config[:build][:dir] do
          
          FileUtils.mkdir_p @config[:build][:css][:dir] unless File.exists? @config[:build][:css][:dir]
          Dir.chdir @config[:build][:css][:dir] do
            
            src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_css
            dst = Pathname.new(@config[:build][:css][:name]).realpath
            FileUtils.mkdir_p File.dirname(dst)
            puts ".... Core CSS file to #{dst}"
            FileUtils.cp src, dst
            
            src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_css_ie
            dst = Pathname.new(@config[:build][:css][:name_ie]).realpath
            FileUtils.mkdir_p File.dirname(dst)
            puts ".... IE CSS file to #{dst}"
            FileUtils.cp src, dst
            
          end
          
          FileUtils.mkdir_p @config[:build][:js][:dir] unless File.exists? @config[:build][:js][:dir]
          Dir.chdir @config[:build][:js][:dir] do
            
            src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_js
            dst = Pathname.new(@config[:build][:js][:name]).realpath
            FileUtils.mkdir_p File.dirname(dst)
            puts ".... Core JS file to #{dst}"
            FileUtils.cp src, dst
            
            src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_js_ie
            dst = Pathname.new(@config[:build][:js][:name_ie]).realpath
            FileUtils.mkdir_p File.dirname(dst)
            puts ".... IE JS file to #{dst}"
            FileUtils.cp src, dst
            
            src = WebBlocks::Util.dir_from_root_through_dir_stack dir_build_temp_js
            dst = Pathname.new(@config[:build][:js][:name_script_dir]).realpath
            FileUtils.mkdir_p File.dirname(dst)
            puts ".... JS scripts to #{dst}"
            FileUtils.cp_r src, dst
            
          end
          
          src = WebBlocks::Util.dir_from_root_through_dir_stack dir_build_temp_js
          dst = Pathname.new(@config[:build][:img][:dir]).realpath
          FileUtils.mkdir_p File.dirname(dst)
          puts ".... Images to #{dst}"
          FileUtils.cp_r src, dst
          
        end
        
      end
      
      def build_cleanup
        FileUtils.rm_rf dir_build_temp
      end
      
      def built?
        File.exists? dir_build
      end

      def clean
        build_cleanup
        FileUtils.rm_rf dir_build
      end
      
    end
    
  end
  
end