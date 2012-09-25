#
# WebBlocks Utility Functions
#

require 'pathname'

module WebBlocks
  
  module Util
        
    # Call-forward to dir_from_dir_stack_array that accepts argument as a set
    # of parameters and passes them on as an array instead. The directories must
    # exist or else this method returns false.
    def self.dir_from_dir_stack *args
      dir_from_dir_stack_array args
    end
    
    # Call-forward like dir_from_dir_stack except that it shifts the dir_root
    # on as the first directory to get paths given relative to the dir_root.
    # The directories must eist or else this method returns false.
    def self.dir_from_root_through_dir_stack *args
      args.unshift dir_root
      dir_from_dir_stack_array args 
    end
        
    # From the current working directory, this method returns the final path
    # as navigated to by changing directory in FIFO order among the array passed
    # to it. This is useful when given a set of paths that may be in relative or
    # absolute order when a final path is needed. The directories must exist or
    # else this returns false.
    def self.dir_from_dir_stack_array args
      if args.length == 0
        Dir.pwd
      elsif
        subdir = args.shift
        begin
          Dir.chdir subdir do
            dir_from_dir_stack_array args
          end
        rescue
          false
        end
      end
    end
    
    # Similar to dir_from_dir_stack except that the final file name is not
    # considered as part of the determined path and instead appended. The 
    # directories must exist or else this return false. The file itself does
    # not need to exist.
    def self.file_from_dir_stack *args
      filepath = args.pop
      args.push File.dirname(filepath) 
      dirpath = dir_from_dir_stack_array args
      dirpath ? "#{dirpath}/#{File.basename filepath}" : false
    end
    
    # Similar to dir_from_root_through_dir_stack except considers a file like
    # file_from_dir_stack. The directories must exist or else this returns
    # false. The file itself does not need to exist.
    def self.file_from_root_through_dir_stack *args
      filepath = args.pop
      args.push File.dirname(filepath)
      args.unshift dir_root
      "#{dir_from_dir_stack_array args}/#{File.basename filepath}"
    end
      
    # The root directory for WebBlocks.
    def self.dir_root
      File.dirname(File.dirname(Pathname.new(__FILE__).realpath))
    end
    
    # Determine if file ends with ext (string or array of strings).
    def self.file_ext? file, ext
      return true unless ext
      ext = ext.join '|' if ext.respond_to? 'join'
      file.match(/.*\.(#{ext})$/)
    end

    # Determine if the file is an SCSS file.
    def self.file_scss? file
      ext? file, 'scss'
    end

    # Determine if the file is a JS file.
    def self.file_js? file
      ext? file, 'js'
    end
    
    # Get a list of all files within the directory specified as dir. If ext is
    # provided (as a string or an array of strings), then it will only return
    # files matching that extension. Unless recursive is set false, this will
    # recursively search all subdirectories for matching files as well. Files
    # are returned in a context that is absolute relative to dir.
    def self.get_files dir, ext = false, recursive = true
      files = []
      begin
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
      rescue
        []
      end
      files
    end
      
    # Appends contents from file src into file dst
    def self.append_contents_to_file src, dst
      contents = File.read src
      File.open dst, "a" do |handle|
        handle.puts contents
      end
    end
    
  end
  
end