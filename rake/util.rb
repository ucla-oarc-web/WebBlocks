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
    
    def self.file_ext? file, ext
      return true unless ext
      ext = ext.join '|' if ext.respond_to? 'join'
      file.match(/.*\.(#{ext})$/)
    end

    def self.file_scss? file
      ext? file, 'scss'
    end

    def self.file_js? file
      ext? file, 'js'
    end
      
    def self.get_files dir, ext = false, recursive = true
      files = []
      Dir.entries(dir).each do |name|
        next if name[0,1] == '.'
        path = "#{dir}/#{name}"
        if File.directory? path
          if recursive
            get_files(path, ext, recursive).each do |sub|
              files.push sub
            end
          elsif !ext
            files.push path
          end
        elsif WebBlocks::Util.file_ext? name, ext
          files.push "#{dir}/#{name}"
        end
      end
      files
    end
    
  end
  
end