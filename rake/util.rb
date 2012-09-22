require 'pathname'

module WebBlocks
  
  module Util
        
    def self.dir_from_dir_stack *args
      dir_from_dir_stack_array args
    end
    
    def self.dir_from_root_through_dir_stack *args
      args.unshift dir_root
      dir_from_dir_stack_array args 
    end
        
    def self.dir_from_dir_stack_array args
      if args.length == 0
        Pathname.new(Dir.pwd)
      elsif
        subdir = args.shift
        Dir.chdir subdir do
          dir_from_dir_stack_array args
        end
      end
    end
    
    def self.file_from_dir_stack *args
      filepath = args.pop
      args.push File.dirname(filepath)
      "#{dir_from_dir_stack_array args}/#{File.basename filepath}"
    end
    
    def self.file_from_root_through_dir_stack *args
      filepath = args.pop
      args.push File.dirname(filepath)
      args.unshift dir_root
      "#{dir_from_dir_stack_array args}/#{File.basename filepath}"
    end
      
    def self.dir_root
      File.dirname(File.dirname(Pathname.new(__FILE__).realpath))
    end
    
  end
  
end