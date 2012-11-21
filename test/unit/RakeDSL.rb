require 'rubygems'
require 'extensions/kernel'
require 'fileutils'
require_relative '../../lib/Test.rb'

class TestUnitRakeDSL < ::Test::Unit::TestCase 
  
  include ::WebBlocks::Test::Unit::TestCase
  
  def assert_methods_exist *methods
    
    methods.each do |method|
      assert ::WebBlocks::Rake.instance_methods.include? method
    end
    
  end
  
  def test_config
    
    assert_methods_exist 'config'
    
  end
  
  def test_logger
    
    assert_methods_exist 'log'
    
  end
  
  def test_rake_manager
    
    assert_methods_exist 'define_task', 'define_tasks'
    
  end
  
  def test_build_dispatcher
    
    assert_methods_exist 'observers', 'observer', 'execute'
    
  end
  
  def test_build_manager
  
    assert_methods_exist 'attach_packages', 'attach_adapters', 'attach_webblocks'
    assert_methods_exist 'attach_core', 'attach_adapter', 'attach_module'
    
  end

end