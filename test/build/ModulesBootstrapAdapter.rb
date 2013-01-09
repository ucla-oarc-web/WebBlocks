require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative 'ModulesCoreAdapter.rb'

class TestModulesBootstrapAdapter < TestModulesCoreAdapter
  
  def setup_test
    WebBlocks.config[:src][:adapter] = 'bootstrap'
  end

end