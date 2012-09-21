module WebBlocks
  
  module Util
        
    def self.dir_from_dir_stack *args
      pwd = Dir.pwd
      args.each do |arg|
        Dir.chdir arg
      end
      path = Pathname.new(Dir.pwd)
      Dir.chdir pwd
      path
    end
    
  end
  
end