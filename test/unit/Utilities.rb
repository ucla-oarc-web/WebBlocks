require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require 'fileutils'
require_relative '../../lib/Test.rb'
require_relative '../../lib/Build/Utilities.rb'

class TestUnitUtilities < ::Test::Unit::TestCase 
  
  include ::WebBlocks::Test::Unit::TestCase
  
  include ::WebBlocks::Build::Utilities
  
  def setup_test
    
    @dir = "#{File.dirname Pathname.new(__FILE__).realpath}/Utilities"
    
    FileUtils.rm_rf @dir
    FileUtils.mkdir_p @dir
    
  end
  
  def teardown_test
    
    FileUtils.rm_rf @dir
    
  end
  
  def test_append_file
    
    file_create "#{@dir}/1", "1"
    file_create "#{@dir}/2", "2"
    
    assert_file_has_pattern "#{@dir}/1", /^1$/, "Initial setup of file"
    assert_file_has_pattern "#{@dir}/2", /^2$/, "Initial setup of file"
    
    append_file "#{@dir}/2", "#{@dir}/1"
    
    assert_file_has_pattern "#{@dir}/1", /^1\s*2$/, "File appended"
    assert_file_has_pattern "#{@dir}/2", /^2$/, "No side-effects during append"
    
  end
  
  def test_file_ext?
    
    assert file_ext? "test", false
    assert_nil file_ext? "test", "js"
    assert_nil file_ext? "test", ["js"]
    assert file_ext? "test.js", "js"
    assert file_ext? "test.js", ["js"]
    assert file_ext? "test.src.js", "js"
    assert file_ext? "test.js", ["css", "js"]
    assert file_ext? "test.css", ["css", "js"]
    
    assert file_scss? "test.scss"
    assert_nil file_scss? "test.js"
    
    assert file_js? "test.js"
    assert_nil file_js? "test.scss"
    
  end
  
  def test_get_contents
    
    # ordered as expected for get_files output
    files = [
      "#{@dir}/1.js",
      "#{@dir}/1.scss",
      "#{@dir}/a/2.js",
      "#{@dir}/a/2.scss",
      "#{@dir}/a/3.js",
      "#{@dir}/a/3.scss",
      "#{@dir}/b/4.js",
      "#{@dir}/b/4.scss",
      "#{@dir}/b/5.js",
      "#{@dir}/b/5.scss",
      "#{@dir}/b/a/6.js",
      "#{@dir}/b/a/6.scss"
      ]
    
    files.each do |file|
      file_create file
    end
    
    assert_equal 12, get_files(@dir).length, "Get files default"
    assert_equal get_files(@dir).length, get_files(@dir, false, true).length, "Get files default is equivalent to recursion and no extension filter"
    assert_equal 6, get_files(@dir, 'scss').length, "Get files with recursion and extension filter"
    assert_equal 12, get_files(@dir, ['scss','js']).length, "Get files with recursion and extension filter array"
    assert_equal 4, get_files(@dir, false, false).length, "Get files (plus directories) without recursion or extension filter"
    assert_equal 1, get_files(@dir, 'scss', false).length, "Get files (plus directories) without recursion but with extension filter"
    assert_equal 2, get_files(@dir, ['scss','js'], false).length, "Get files (plus directories) without recursion but with extension filter array"
    
    files_result = get_files(@dir)
    files.each_index do |idx|
      assert_equal files[idx], files_result[idx], "Get files returns files in the expected order"
    end
    
  end
  
  def file_create file, contents = ''
    
    FileUtils.mkdir_p File.dirname(file)
    
    File.open(file, 'w') { |f| f.puts contents }
    
  end
  
  
end