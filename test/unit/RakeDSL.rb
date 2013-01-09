require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
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
    
    assert_method_exists :config, 'Config includes config method in DSL'
    
  end
  
  def test_logger
    
    assert_method_exists :log, 'Logger includes log method in DSL'
    
  end
  
  def test_rake_manager
    
    assert_method_exists :define_task, 'Rake manager includes define_task method in DSL'
    assert_method_exists :define_tasks, 'Rake manager includes define_tasks method in DSL'
    
  end
  
  def test_build_dispatcher
    
    assert_method_exists :observers, 'Build dispatcher includes observers method in DSL'
    assert_method_exists :reset_observers, 'Build dispatcher includes reset_observers method in DSL'
    assert_method_exists :observer, 'Build dispatcher includes observer method in DSL'
    assert_method_exists :execute, 'Build dispatcher includes execute method in DSL'
    
  end
  
  def test_build_manager
  
    assert_method_exists :attach_packages, 'Build manager includes attach_packages method in DSL'
    assert_method_exists :attach_adapters, 'Build manager includes attach_adapters method in DSL'
    assert_method_exists :attach_webblocks, 'Build manager includes attach_webblocks method in DSL'
    assert_method_exists :attach_core, 'Build manager includes attach_core method in DSL'
    assert_method_exists :attach_adapter, 'Build manager includes attach_adapter method in DSL'
    assert_method_exists :attach_module, 'Build manager includes attach_module method in DSL'
    
  end

end