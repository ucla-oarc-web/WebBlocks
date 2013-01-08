require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require 'fileutils'
require_relative '../../lib/Test.rb'

class TestUnitBuildDispatcher < ::Test::Unit::TestCase 
  
  include ::WebBlocks::Test::Unit::TestCase
  
  class TestObserver
    
    attr_accessor :counter
    
    def initialize
      
      @counter = 0
      
    end
    
    def event
      
      @counter += 1
      
    end
    
  end
  
  def setup_test
    
    reset_observers
    assert_equal 0, observers.length
    
  end
  
  
  def test_execute_dispatch
    
    test_observer = TestObserver.new
    
    observer test_observer
    execute 'event'
    
    assert_equal 1, test_observer.counter
    
  end
  
  
  def test_execute_dispatch_hooks
    
    test_observer = TestObserver.new
    
    def test_observer.before_event; @counter += 1 end
    def test_observer.after_event; @counter += 1 end
    
    observer test_observer
    execute 'event'
    
    assert_equal 3, test_observer.counter
    
  end
  
end