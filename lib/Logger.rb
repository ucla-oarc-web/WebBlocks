module WebBlocks
  
  module Logger
    
    include ::WebBlocks::Config
    
    @@log = false
    
    def log
      @@log = ::WebBlocks::Logger::Logger.new config[:build][:log][:name] unless @@log
      @@log
    end
    
    class Logger
    
      attr_accessor :file

      def initialize file
        @file = file
        @file_handle = File.open @file, "w"
        @scope = 0
        @types = [:system, :task, :failure, :success, :warning, :info, :debug]
        @type = :system
        if ::WebBlocks.config[:options][:details]
          @types_to_print = [:system, :task, :failure, :success, :warning]
        else
          @types_to_print = [:system, :failure, :warning]
        end
        @types_to_file = [:system, :task, :failure, :success, :warning, :info, :debug]
      end

      def types_to_print arr
        arr = @types if arr == :all
        @types_to_print = arr
      end

      def types_to_file arr
        arr = @types if arr == :all
        @types_to_file = arr
      end

      def system category, message = false
        scope :system, category, message do
          yield if block_given?
        end
      end

      def task category, message = false
        scope :task, category, message do
          yield if block_given?
        end
      end

      def failure category, message = false
        scope :failure, category, message do
          yield if block_given?
        end
        fail "#{message ? message : category}"
      end

      def success category, message = false
        scope :success, category, message do
          yield if block_given?
        end
      end

      def warning category, message = false
        scope :warning, category, message do
          yield if block_given?
        end
      end

      def info category, message = false
        scope :info, category, message do
          yield if block_given?
        end
      end

      def debug category, message = false
        scope :debug, category, message do
          yield if block_given?
        end
      end

      def write type, category, message = false
        text = message ? "[#{category}] #{message}" : "#{category}"
        text = "#{'  ' * @scope}#{text}".gsub "\n", "\n#{'  ' * @scope}"
        puts text if @types_to_print.include? type unless ::WebBlocks.config[:options][:silent]
        @file_handle.puts text if @types_to_file.include? type
      end

      def scope type, category = false, message = false
        prev = @type
        @type = type if @types.index(type) > @types.index(@type)
        write @type, category, message if category
        scope_start
        yield if block_given?
        scope_end
        @type = prev
      end

      def scope_start
        @scope += 1
      end

      def scope_end
        @scope -= 1 if @scope > 0
      end

    end
    
  end
  
end