require 'rubygems'
require 'extensions/kernel'

module WebBlocks
  
  module Rake
    
    module Manager
      
      def define_tasks
        
        Dir.chdir(File.dirname(Pathname.new(__FILE__).realpath)) do
          Dir.chdir("Task") do
            Dir.entries(Dir.pwd).sort.each do |file|
              next if file[0,1] == '.'
              require file
            end
          end
        end
        
      end
      
      def define_task task
        
        Dir.chdir(File.dirname(Pathname.new(__FILE__).realpath)) do
          Dir.chdir("Task") do
            require task
          end
        end
        
      end
      
    end
    
  end
  
end