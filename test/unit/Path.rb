require 'rubygems'
require 'extensions/kernel'
require 'fileutils'
require_relative '../../lib/Test.rb'

class TestUnitPath < ::Test::Unit::TestCase 
  
  include ::WebBlocks::Test::Unit::TestCase
  
  include ::WebBlocks::Path::Build
  include ::WebBlocks::Path::Root
  include ::WebBlocks::Path::Source
  include ::WebBlocks::Path::Temporary_Build
  
  def test_path
    
    root = File.dirname Pathname.new(__FILE__).realpath
    
    Dir.chdir root do
      assert_equal ::WebBlocks::Path.to, root
      assert_equal ::WebBlocks::Path.to('../..'), File.dirname(File.dirname root)
      assert_equal ::WebBlocks::Path.to('..', '..'), File.dirname(File.dirname root)
      assert_equal ::WebBlocks::Path.to('..', File.basename(root)), root
      assert_equal ::WebBlocks::Path.to('../..', root), root
      assert_equal ::WebBlocks::Path.from_root_to, File.dirname(File.dirname root)
      assert_equal ::WebBlocks::Path.from_root_to(File.basename(File.dirname root), File.basename(root)), root
    end
    
  end
  
  def test_path_build
    
    config[:build][:dir] = '.build-test'
    
    config[:build][:css] = {
      :dir      => 'css',
      :name     => 'blocks.css',
      :name_ie  => 'blocks-ie.css'
    }

    config[:build][:js] = {
      :dir                => 'js',
      :name               => 'blocks.js',
      :name_ie            => 'blocks-ie.js',
      :name_script_dir    => 'script'
    }

    config[:build][:img] = {
      :dir      => 'img'
    }
    
    build = "#{File.dirname File.dirname File.dirname Pathname.new(__FILE__).realpath}/.build-test"
    
    FileUtils.mkdir_p "#{build}/css"
    FileUtils.mkdir_p "#{build}/img"
    FileUtils.mkdir_p "#{build}/js/script"
    FileUtils.touch "#{build}/css/blocks.css"
    FileUtils.touch "#{build}/css/blocks-ie.css"
    FileUtils.touch "#{build}/js/blocks.js"
    FileUtils.touch "#{build}/js/blocks-ie.js"
    
    assert_equal build, build_dir
    assert_equal "#{build}/css/blocks.css", from_build_dir_to('css','blocks.css')
    assert_equal "#{build}/css", css_build_dir
    assert_equal "#{build}/css/blocks.css", css_build_file
    assert_equal "#{build}/css/blocks-ie.css", css_build_file_ie
    assert_equal "#{build}/img", img_build_dir
    assert_equal "#{build}/js", js_build_dir
    assert_equal "#{build}/js/blocks.js", js_build_file
    assert_equal "#{build}/js/blocks-ie.js", js_build_file_ie
    assert_equal "#{build}/js/script", js_build_script_dir
    
    
  end
  
  def test_path_source
    
    root = File.dirname File.dirname File.dirname Pathname.new(__FILE__).realpath
    
    config[:package][:dir] = 'package'
    config[:package][:jquery][:dir] = 'jquery'
    config[:src][:dir] = 'src'
    config[:src][:core][:dir] = 'core'
    config[:src][:core][:adapter][:dir] = 'adapter'
    config[:src][:core][:definitions][:dir] = 'definitions'
    config[:src][:core][:compass][:config] = 'config.rb'
    config[:src][:adapters][:dir] = 'adapter'
    config[:src][:extension][:dir] = 'extension'
    config[:src][:sass][:dir] = 'sass'
    config[:src][:sass][:includes][:dir] = 'includes'
    config[:src][:css][:dir] = 'css'
    config[:src][:img][:dir] = 'img'
    config[:src][:js][:dir] = 'js'
    config[:src][:js][:core][:dir] = 'core'
    config[:src][:js][:core_ie][:dir] = 'core-ie'
    config[:src][:js][:script][:dir] = 'script'
    
    assert_equal root, root_dir
    assert_equal "#{root}/package/jquery", package_dir(:jquery)
    assert_equal "#{root}/src", src_dir
    assert_equal "#{root}/src/core/adapter", from_src_dir_to('core', 'adapter')
    assert_equal false, from_src_dir_to('does', 'not', 'exist')
    assert_equal "#{root}/src/core/adapter", src_core_adapter_dir
    assert_equal "#{root}/src/core/definitions", src_core_definitions_dir
    assert_equal "#{root}/src/core/config.rb", src_core_compass_config_file
    assert_equal "#{root}/src/core/adapter/base/_reset.scss", from_src_core_adapter_dir_to('base', '_reset.scss')
    assert_equal false, from_src_core_adapter_dir_to('does', 'not', 'exist') 
    assert_equal "#{root}/src/core/definitions/base/_reset.scss", from_src_core_definitions_dir_to('base', '_reset.scss')
    assert_equal false, from_src_core_definitions_dir_to('does', 'not', 'exist') 
    assert_equal "#{root}/src/adapter", src_adapter_dir
    assert_equal "#{root}/src/adapter/bootstrap", src_adapter_dir('bootstrap')
    assert_equal "#{root}/src/extension", src_extensions_dir
    assert_equal "#{root}/src/extension/implicit-html/_implicit-html.scss", from_src_extensions_dir_to('implicit-html','_implicit-html.scss')
    assert_equal false, from_src_extensions_dir_to('does', 'not', 'exist')
    assert_equal "#{root}/src/sass", src_sass_dir
    assert_equal "#{root}/src/sass/includes", src_sass_includes_dir
    assert_equal "#{root}/src/css", src_css_dir
    assert_equal "#{root}/src/img", src_img_dir
    assert_equal "#{root}/src/js", src_js_dir
    assert_equal "#{root}/src/js/core", src_js_core_dir
    assert_equal "#{root}/src/js/core-ie", src_js_core_ie_dir
    assert_equal "#{root}/src/js/script", src_js_script_dir
    
  end
  
  def test_path_temporary_build
    
    config[:build][:css] = {
      :dir      => 'css',
      :name     => 'blocks.css',
      :name_ie  => 'blocks-ie.css'
    }

    config[:build][:js] = {
      :dir                => 'js',
      :name               => 'blocks.js',
      :name_ie            => 'blocks-ie.js',
      :name_script_dir    => 'script'
    }

    config[:build][:img] = {
      :dir      => 'img'
    }
    
    tmp_build = "#{File.dirname File.dirname File.dirname Pathname.new(__FILE__).realpath}/.build-tmp"
    
    FileUtils.rm_rf tmp_build
    FileUtils.mkdir_p "#{tmp_build}/css/compiled"
    FileUtils.mkdir_p "#{tmp_build}/img"
    FileUtils.mkdir_p "#{tmp_build}/js/script"
    FileUtils.mkdir_p "#{tmp_build}/sass"
    FileUtils.touch "#{tmp_build}/css/blocks.css"
    FileUtils.touch "#{tmp_build}/css/blocks-ie.css"
    FileUtils.touch "#{tmp_build}/js/blocks.js"
    FileUtils.touch "#{tmp_build}/js/blocks-ie.js"
    FileUtils.touch "#{tmp_build}/sass/_WebBlocks-ie.scss"
    FileUtils.touch "#{tmp_build}/sass/_WebBlocks-require.scss"
    FileUtils.touch "#{tmp_build}/sass/_WebBlocks-variables.scss"
    FileUtils.touch "#{tmp_build}/sass/_WebBlocks.scss"
    
    assert_equal tmp_build, tmp_build_dir
    assert_equal "#{tmp_build}/css/blocks.css", from_tmp_build_dir_to('css','blocks.css')
    assert_equal "#{tmp_build}/css", tmp_css_build_dir
    assert_equal "#{tmp_build}/css/blocks.css", tmp_css_build_file
    assert_equal "#{tmp_build}/css/blocks-ie.css", tmp_css_build_file_ie
    assert_equal "#{tmp_build}/img", tmp_img_build_dir
    assert_equal "#{tmp_build}/js", tmp_js_build_dir
    assert_equal "#{tmp_build}/js/blocks.js", tmp_js_build_file
    assert_equal "#{tmp_build}/js/blocks-ie.js", tmp_js_build_file_ie
    assert_equal "#{tmp_build}/js/script", tmp_js_build_script_dir
    assert_equal "#{tmp_build}/sass", tmp_sass_lib_dir
    assert_equal "#{tmp_build}/sass/_WebBlocks-ie.scss", tmp_sass_lib_file_ie
    assert_equal "#{tmp_build}/sass/_WebBlocks-require.scss", tmp_sass_lib_file_require
    assert_equal "#{tmp_build}/sass/_WebBlocks-variables.scss", tmp_sass_lib_file_variables
    assert_equal "#{tmp_build}/sass/_WebBlocks.scss", tmp_sass_lib_file
    
  end

end