require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require 'fileutils'
require_relative '../../lib/Test.rb'

class TestUnitBuildManager < ::Test::Unit::TestCase 
  
  include ::WebBlocks::Test::Unit::TestCase
  
  def setup_test
    
    reset_observers
    assert_equal 0, observers.length
    
  end
  
  def test_attach_webblocks
    
    attach_webblocks
    
    assert_kind_of ::WebBlocks::Build::WebBlocks, observers[0]
    
  end
  
  def test_attach_module
    
    attach_module 'package', 'jquery'
    
    assert_kind_of ::WebBlocks::Build::Package::Jquery, observers[0]
    
  end
  
  def test_attach_packages
    
    config[:src][:packages] = [:jquery]
      
    attach_packages
    
    assert_equal config[:src][:packages].length, observers.length
    assert_kind_of ::WebBlocks::Build::Package::Jquery, observers[0]
    
  end
  
  def test_attach_packages_all_with_handlers
    
    config[:src][:packages] = [:jquery, :modernizr, :respond, :selectivizr, :efx]
      
    attach_packages
    
    assert_equal config[:src][:packages].length, observers.length
    
    idx = 0
    config[:src][:packages].each do |package|
      assert_kind_of eval("::WebBlocks::Build::Package::#{package.to_s.capitalize}"), observers[idx]
      idx += 1
    end
    
  end
  
  def test_attach_core
    
    attach_core 'adapter'
    attach_core 'extensions'
    attach_core 'definitions'
    
    assert_kind_of ::WebBlocks::Build::Core::Adapter, observers[0]
    assert_kind_of ::WebBlocks::Build::Core::Extensions, observers[1]
    assert_kind_of ::WebBlocks::Build::Core::Definitions, observers[2]
    
  end
  
  def test_attach_adapter
    
    attach_adapter 'bootstrap'
    
    assert_kind_of ::WebBlocks::Build::Adapter::Bootstrap, observers[0]
    
  end
  
end