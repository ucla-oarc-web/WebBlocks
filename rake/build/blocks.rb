require 'fileutils'
require 'pathname'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"

module WebBlocks
  
  module Build
    
    class Blocks < Builder

      def init
        FileUtils.mkdir @config[:build][:dir_metadata]
      end
      
      def init?
        File.exists? @config[:build][:dir_metadata]
      end
      
      def reset
        FileUtils.rm_rf @config[:build][:dir_metadata]
      end
      
      def build
        begin
          FileUtils.mkdir @config[:build][:dir_tmp]
          # TODO: the actual compile process
          FileUtils.rm_rf @config[:build][:dir]
          FileUtils.cp_r @config[:build][:dir_tmp], @config[:build][:dir]
        ensure
          FileUtils.rm_rf @config[:build][:dir_tmp]
        end
      end
      
      def built?
        File.exists? @config[:build][:dir]
      end

      def clean
        FileUtils.rm_rf @config[:build][:dir]
      end
      
    end
    
  end
  
end