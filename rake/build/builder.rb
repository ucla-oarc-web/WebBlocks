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
      
      def file_build_temp_css
        "#{@config[:build][:dir_tmp]}/core.css"
      end
      
      def file_build_temp_css_ie
        "#{@config[:build][:dir_tmp]}/ie.css"
      end
      
      def file_build_temp_js
        "#{@config[:build][:dir_tmp]}/core.js"
      end
      
      def file_build_temp_js_ie
        "#{@config[:build][:dir_tmp]}/ie.js"
      end
      
      def dir_build_temp_js
        "#{@config[:build][:dir_tmp]}/script"
      end
      
      def dir_build_temp_img
        "#{@config[:build][:dir_tmp]}/img"
      end

      def dir_build_metadata
        @config[:build][:dir_metadata]
      end
      
      def append_contents_to_file src, dst
        contents = File.read src
        File.open dst, "a" do |handle|
          handle.puts contents
        end
      end
      
    end
    
  end
  
end