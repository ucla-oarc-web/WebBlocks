require 'pathname'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/util.rb"

module WebBlocks
  
  module Build
    
    class Builder
      
      attr_accessor :config
      
      def initialize(config)
        @config = config
      end
        
      def dir_build
        @config[:build][:dir]
      end

      def dir_build_temp
        @config[:build][:dir_tmp]
      end

      def dir_build_metadata
        @config[:build][:dir_metadata]
      end
      
    end
    
  end
  
end