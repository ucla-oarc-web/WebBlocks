require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative '../../lib/Test.rb'

class TestBuildDefaults < ::Test::Unit::TestCase 
  
  include ::WebBlocks::Test::Unit::TestCase
  
  def test_build
    assert_nothing_raised(RuntimeError) do
      execute "preprocess"
      execute "link"
      execute "compile"
      execute "assemble"
      execute "package"
      execute "postprocess"
    end
  end

end