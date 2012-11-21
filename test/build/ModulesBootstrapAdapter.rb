require 'rubygems'
require 'extensions/kernel'
require_relative 'ModulesCoreAdapter.rb'

class TestModulesBootstrapAdapter < TestModulesCoreAdapter
  
  def setup_test
    WebBlocks.config[:src][:adapter] = 'bootstrap'
  end

end