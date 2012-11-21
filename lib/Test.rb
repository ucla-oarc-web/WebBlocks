require 'rubygems'
require 'extensions/kernel'
require 'systemu'
require 'test/unit'
require 'pathname'
require_relative 'Rake.rb'
require_relative 'Path.rb'

module WebBlocks
  
  module Test
    
    module Unit
      
      module TestCase
        
        # include DSL: Rake
        include ::Rake::DSL

        # include variable: config
        include ::WebBlocks::Config

        # include variable: log
        include ::WebBlocks::Logger

        # include methods: define_task, define_tasks
        include ::WebBlocks::Rake::Manager

        # include methods: observer, execute
        include ::WebBlocks::Build::Dispatcher

        # include methods: attach_packages, attach_adapters, attach_webblocks
        include ::WebBlocks::Build::Manager
        
        def setup
          
          ::WebBlocks.config[:loaded] = false

          config[:build][:src] = "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/.build-test"
          FileUtils.rm_rf config[:build][:src]
          FileUtils.mkdir_p config[:build][:src]

          attach_packages
          attach_adapters
          attach_webblocks
          
          if self.respond_to? :setup_test
            self.setup_test
          end

        end

        def teardown
          
          if self.respond_to? :teardown_test
            self.teardown_test
          end

        end
        
        def test
          
          
          
        end

      end
      
    end
    
  end
  
end