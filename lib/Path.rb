require 'pathname'

module WebBlocks
  
  module Path
    
    module Sources
      
      def package_dir package
        ::WebBlocks::Path.from_root_to config[:package][:dir], config[:package][package][:dir]
      end
      
    end
    
    def self.to *args
      ::WebBlocks::Path.from_arr_to(args)
    end
    
    def self.from_arr_to args
      
      return Dir.pwd unless args and args.length > 0
      
      subdir = args.shift
      begin
        Dir.chdir subdir do
          ::WebBlocks::Path.from_arr_to(args)
        end
      rescue
        if args.length == 0
          begin
            Dir.chdir File.dirname(subdir) do
              return "#{Dir.pwd}/#{File.basename(subdir)}"
            end
          rescue
            false
          end
        end
        false
      end
      
    end
    
    def self.from_root_to *args
      
      Dir.chdir File.dirname(File.dirname(Pathname.new(__FILE__).realpath)) do
        ::WebBlocks::Path.from_arr_to(args)
      end
      
    end
    
  end
  
end