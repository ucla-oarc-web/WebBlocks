require 'fileutils'
require 'pathname'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"

module WebBlocks
  
  module Build
    
    class Blocks < Builder
      
      def init
        FileUtils.mkdir dir_build_metadata unless init?
      end
      
      def init?
        File.exists? dir_build_metadata
      end
      
      def reset
        FileUtils.rm_rf dir_build_metadata
      end
      
      def build_setup
        FileUtils.mkdir dir_build_temp unless File.exists? dir_build_temp
      end
      
      def build
        FileUtils.rm_rf dir_build
        FileUtils.cp_r dir_build_temp, dir_build
      end
      
      def build_cleanup
        FileUtils.rm_rf dir_build_temp
      end
      
      def built?
        File.exists? dir_build
      end

      def clean
        FileUtils.rm_rf dir_build
      end
      
    end
    
  end
  
end