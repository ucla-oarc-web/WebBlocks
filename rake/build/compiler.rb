#
# WebBlocks Compiler Base Class
# 
# The WebBlocks::Build::Compiler is a base clase used by both the WebBlocks
# compiler itself in WebBlocks::Build::Blocks::Compiler and by the adapter
# compilers in /rake/build/adapter including the adapter compiler base class
# Rake::Build::Adapter::Compiler.
# 
# This class should not be used as a compiler itself as it does not respond
# to the compile method.
#

require 'pathname'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/util.rb"

module WebBlocks
  
  module Build
    
    class Compiler
      
      attr_accessor :config
      attr_accessor :dir_build_temp
      attr_accessor :dir_src
      attr_accessor :dir_build_temp_sass
      attr_accessor :file_build_temp_js
      attr_accessor :file_build_temp_js_ie
      
      def initialize(config)
        @config = config
        @dir_build_temp = WebBlocks::Util.dir_from_root_through_dir_stack @config[:build][:dir_tmp] 
        @dir_build_temp_sass = "#{dir_build_temp}/sass"
        @file_build_temp_js = "#{dir_build_temp}/core.js"
        @file_build_temp_js_ie = "#{dir_build_temp}/ie.js"
        @dir_src = WebBlocks::Util.dir_from_root_through_dir_stack @config[:src][:dir]
      end

      # Returns an array of module (subdirectories) under dir. Unless recursive
      # is set to false, this will include all subdirectories recursively.
      def get_modules dir, recursive = true
        mods = []
        Dir.entries(dir).each do |name|
          next if name[0,1] == '.'
          path = "#{dir}/#{name}"
          if File.directory? path
            if recursive
              get_modules(path, recursive).each do |sub|
                mods.push sub
              end
            else
              mods.push path
            end
          elsif WebBlocks::Util.file_ext? name, ['scss', 'js']
            name = name.sub /\.(scss|js)$/, ''
            name = name.sub /^\_/, ''
            mods.push "#{dir}/#{name}"
          end
        end
        mods
      end
      
      # Call-forward to WebBlocks::Util.get_files to return all files within
      # dir, optionally filtered by the extension ext and can be set
      # non-recursive by setting recursive to false.
      def get_files dir, ext = false, recursive = true
        WebBlocks::Util.get_files dir, ext, recursive
      end
      
      def append_contents_to_file src, dst
        WebBlocks::Util.append_contents_to_file src, dst
      end
      
      def append_compressed_css_to_file src, dst
        status, stdout, stderr = systemu "#{@config[:exec][:uglifycss]} \"#{src}\" >> \"#{dst}\""
        status == 0
      end
      
      def append_compressed_js_to_file src, dst
        status, stdout, stderr = systemu "#{@config[:exec][:uglifyjs]} \"#{src}\" --extras --unsafe >> \"#{dst}\""
        status == 0
      end
      
    end
    
  end
  
end