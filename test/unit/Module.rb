require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require 'fileutils'
require_relative '../../lib/Test.rb'
require_relative '../../lib/Build/Module.rb'
require_relative '../../lib/Build/WebBlocks.rb'
  
# TODO: add unit tests for assemble_img_files_for
# TODO: add unit tests for assemble_js_libs_into_file_for
# TODO: add unit tests for assemble_js_libs_for

class TestUnitModule < ::Test::Unit::TestCase 
  
  include ::WebBlocks::Test::Unit::TestCase
  
  include ::WebBlocks::Path::Build
  include ::WebBlocks::Path::Root
  include ::WebBlocks::Path::Source
  include ::WebBlocks::Path::Temporary_Build
  include ::WebBlocks::Build::Module
  
  def setup_test
  
    config[:src][:core] = {
      :dir => "#{File.dirname(Pathname.new(__FILE__).realpath)}/Mock/src/core",
      :compass => {
        :config => 'config.rb'
      },
      :definitions => {
        :dir => 'definitions'
      },
      :adapter => {
        :dir => 'adapter'
      }
    }
    
  end
  
  def test_all_modules
    
    assert_equal 3, all_modules.length, "All modules detects all modules"
    
  end
  
  def test_modules
    
    config[:src][:modules] = :all
    assert_equal 3, modules.length, "Modules detected for :all"
    
    one_module = modules[0]
    
    config[:src][:modules] = [one_module]
    assert_equal 1, modules.length, "Module detected from explicit array"
    
    config[:src][:modules] = one_module
    assert_equal 1, modules.length, "Module detected from explicit string"
    
  end
  
  def test_sass_libs_for
    
    config[:src][:modules] = :all
    assert_equal 7, sass_libs_for(src_core_definitions_dir).length, "All core definitions files detected" 
    assert_equal 12, sass_libs_for(src_core_adapter_dir).length, "All core definitions files detected" 
    
    config[:src][:modules] = 'm1'
    assert_equal 3, sass_libs_for(src_core_definitions_dir).length, "All core definitions files detected for single module" 
    assert_equal 8, sass_libs_for(src_core_adapter_dir).length, "All core definitions files detected for single module" 
    
    config[:src][:modules] = 'm1/sub1'
    assert_equal 2, sass_libs_for(src_core_definitions_dir).length, "Core definition including file by module name and within module directory"
    assert_equal 7, sass_libs_for(src_core_adapter_dir).length, "Core definition including file by module name and within module directory"
    
    config[:src][:modules] = 'm3/sub1'
    assert_equal 1, sass_libs_for(src_core_definitions_dir).length, "Core definition including file by module name and within module directory"
    assert_equal 4, sass_libs_for(src_core_adapter_dir).length, "Core definition including file by module name and within module directory"
    
  end
  
  def test_find_sass_dependencies
    
    assert_equal 2, find_sass_dependencies("#{src_core_adapter_dir}/m3").length, "Finds SASS dependencies based on //! requires mod [mod [mod ..]]"
    
  end
  
  def test_resolve_sass_dependencies
    
    base_dir = "#{File.dirname(Pathname.new(__FILE__).realpath)}/Mock/src/adapters/dependencyTest"
    
    config[:src][:modules] = 'm2'
    resolve_sass_dependencies base_dir
    assert_equal 2, config[:src][:modules].length, "Resolved non-cyclical dependency"
    
    
    config[:src][:modules] = ['m1','m3']
    resolve_sass_dependencies base_dir
    assert_equal 3, config[:src][:modules].length, "Resolved cyclical dependency"
      
  end
  
  def test_link_sass_lib
    
    link_sass_lib "test/_test.scss"
    assert_file_has_import_rule tmp_sass_lib_file, "test/_test.scss", "Add include to _WebBlocks-variables.scss"
    
    link_sass_lib "test/_test-ie.scss"
    assert_file_has_import_rule tmp_sass_lib_file_ie, "test/_test-ie.scss", "Add IE include to _WebBlocks-ie.scss"
    
    link_sass_lib "test/_require.scss"
    assert_file_has_import_rule tmp_sass_lib_file_require, "test/_require.scss", "Add require include to _WebBlocks-require.scss"
    
    link_sass_lib "test/_variables.scss"
    assert_file_has_import_rule tmp_sass_lib_file_variables, "test/_variables.scss", "Add variables include to _WebBlocks-variables.scss"
    
  end
  
  def test_link_sass_libs_for
    
    config[:src][:modules] = :all
    link_sass_libs_for src_core_adapter_dir
    
    assert_file_has_import_rule tmp_sass_lib_file, "#{src_core_adapter_dir}/m1/_sub1.scss", "Import set for regular SASS lib"
    
    assert_file_has_import_rule tmp_sass_lib_file_ie, "#{src_core_adapter_dir}/m1/_sub1-ie.scss", "Import set for IE SASS lib"
    
    assert_file_has_import_rule tmp_sass_lib_file_require, "#{src_core_adapter_dir}/_require.scss", "Import set for require SASS lib"
    assert_file_has_import_rule tmp_sass_lib_file_require, "#{src_core_adapter_dir}/m1/_require.scss", "Import set for submodule require SASS lib"
    
    assert_file_has_import_rule tmp_sass_lib_file_variables, "#{src_core_adapter_dir}/_variables.scss", "Import set for variables SASS lib"
    assert_file_has_import_rule tmp_sass_lib_file_variables, "#{src_core_adapter_dir}/m1/_variables.scss", "Import set for submodule variables SASS lib"
    
  end

end