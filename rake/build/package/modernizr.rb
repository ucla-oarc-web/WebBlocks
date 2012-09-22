require 'pathname'
require 'systemu'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Modernizr < Builder

        def dir_package
          
          generate_dir_package @config[:package][:modernizr][:dir]
          
        end
        
        def build
          
          puts ".. Managing Modernizr submodule"
          
          status, stdout, stderr = systemu "#{@config[:exec][:git]} submodule init #{dir_package}"
          puts ".... Initialized Modernizr submodule" if stdout.length > 0
          
          status, stdout, stderr = systemu "#{@config[:exec][:git]} submodule update #{dir_package}"
          puts ".... Updated Modernizr submodule" if stdout.length > 0
          
          puts ".. Packaging Modernizr into Core JS file"
          
          if @config[:build][:debug]
            append_contents_to_file "#{dir_package}/modernizr.js", file_build_temp_js
          elsif
            append_compressed_js_to_file "#{dir_package}/modernizr.js", file_build_temp_js
          end
          
        end
        
        def clean
          
          puts ".. Removing jQuery dist directory"
          FileUtils.rm_rf "#{dir_package}/dist"
          
        end
        
        def reset
          
          puts ".. Removing checkout of jQuery submodule"
          FileUtils.rm_rf "#{dir_package}"
          
        end
      
      end
      
    end
    
  end
  
end