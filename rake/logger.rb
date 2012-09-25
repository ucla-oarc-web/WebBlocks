module WebBlocks
  
  class Logger
    
    attr_accessor :file
    
    def initialize file
      @file = file
      FileUtils.touch file
      @scope = 0
    end
    
    def task category, message
      scope :task, category, "task: #{message}" do
        yield if block_given?
      end
    end
    
    def write type, category, message = false
      puts message ? "#{'  ' * @scope}[#{category}] #{message}" : "#{'  ' * @scope}#{category}"
    end
    
    def scope type, category = false, message = false
      write type, category, message if category
      scope_start
      yield if block_given?
      scope_end
    end
    
    def scope_start
      @scope += 1
    end
    
    def scope_end
      @scope -= 1 if @scope > 0
    end
    
  end
  
end