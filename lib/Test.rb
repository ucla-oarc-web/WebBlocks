require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
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

          config[:build][:dir] = "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/.build-test"
          FileUtils.rm_rf config[:build][:dir]
          FileUtils.mkdir_p config[:build][:dir]

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
  
        def assert_file_exists file, message = ''

          assert File.exists?(file), message

        end

        def assert_file_does_not_exist file, message = ''

          assert_equal false, File.exists?(file), message

        end

        def assert_file_has_pattern file, pattern, message = ''

          assert_not_nil (File.open(file, 'rb') { |f| f.read }).match(pattern), message

        end

        def assert_file_does_not_have_pattern file, pattern, message = ''

          assert_nil (File.open(file, 'rb') { |f| f.read }).match(pattern), message

        end

        def assert_file_has_css_selector file, selector, message = ''

          assert_file_has_pattern file, /#{Regexp.escape(selector)}\s*\{/, message

        end

        def assert_file_has_js_var file, variable, message = ''

          assert_file_has_pattern file, /var\s\s*#{Regexp.escape(variable)}\s*=/, message

        end

        def assert_file_does_not_have_js_var file, variable, message = ''

          assert_file_does_not_have_pattern file, /var\s\s*#{Regexp.escape(variable)}\s*=/, message

        end
        
        def assert_file_has_import_rule file, rule, message = ''

          assert_file_has_pattern file, /\@import "#{Regexp.escape(rule)}";/, message

        end
        
        def assert_method_exists method, msg = ''
          
          assert respond_to?(method), msg
          
        end

      end
      
    end
    
  end
  
end