require 'rubygems'
require 'extensions/kernel'
require 'systemu'
require 'fileutils'
require_relative '../Path.rb'

module WebBlocks
  
  module Build
      
    module Utilities
      
      def append_file src, dst
        
        contents = File.read src
        File.open dst, "a" do |handle|
          handle.puts contents
        end
        
      end
      
    end
    
  end
  
end