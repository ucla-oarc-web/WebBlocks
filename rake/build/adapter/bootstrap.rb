require 'pathname'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/compiler.rb"

module WebBlocks
  
  module Build
  
    module Adapter
    
      class Bootstrap < Compiler
      
        # TODO: Custom behaviors for compiling when Bootstrap adapter is enabled
        
      end
      
    end
    
  end
  
end