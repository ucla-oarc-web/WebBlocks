require 'rubygems'
require 'extensions/kernel'
require 'fileutils'
require_relative '../../lib/Test.rb'
require_relative '../../lib/Build/WebBlocks.rb'

class TestUnitWebBlocks < ::Test::Unit::TestCase 
  
  include ::WebBlocks::Test::Unit::TestCase
  
  include ::WebBlocks::Path::Build
  include ::WebBlocks::Path::Root
  include ::WebBlocks::Path::Source
  include ::WebBlocks::Path::Temporary_Build
  
  def setup_test
  
    reset_observers
    observer WebBlocks::Build::WebBlocks.new
    assert_equal 1, observers.length
    
  end
  
  def test_init
    
    execute 'reset'
    execute 'init'
    
    assert File.exists? "#{root_dir}/.blocks"
    
  end
  
  def test_preprocess_css
    
    execute 'preprocess_css'
    
    assert_file_exists tmp_build_dir, "Temporary build directory created"
    assert_file_exists tmp_css_build_dir, "CSS temporary build directory created"
    assert_file_exists tmp_sass_lib_file, "SASS lib file created"
    assert_file_exists tmp_sass_lib_file_ie, "SASS -ie lib file created"
    assert_file_exists tmp_sass_lib_file_require, "SASS -require lib file created"
    assert_file_exists tmp_sass_lib_file_variables, "SASS -variables lib file created"
    
  end
  
  def test_preprocess_img
    
    execute 'preprocess_img'
    
    assert_file_exists tmp_build_dir, "Temporary build directory created"
    assert_file_exists tmp_img_build_dir, "Images temporary build directory created"
    
  end
  
  def test_preprocess_js
    
    execute 'preprocess_js'
    
    assert_file_exists tmp_build_dir, "Temporary build directory created"
    assert_file_exists tmp_js_build_dir, "JS temporary build directory created"
    assert_file_exists tmp_js_build_file, "JS temporary build file created"
    assert_file_exists tmp_js_build_file_ie, "JS temporary IE build file created"
    assert_file_exists tmp_js_build_script_dir, "JS temporary scripts build directory created"
    
  end
  
  def test_link_css
    
    config[:src][:sass][:dir] = "#{File.dirname(Pathname.new(__FILE__).realpath)}/WebBlocks/src/sass"
    
    execute 'preprocess_css'
    execute 'link_css'
    
    assert_file_has_import_rule tmp_sass_lib_file_variables, "#{config[:src][:sass][:dir]}/_variables.scss", "Import rule set for variables in SASS directory to _WebBlocks-variables.scss"
    assert_file_has_import_rule tmp_sass_lib_file_variables, "#{config[:src][:sass][:dir]}/dir/_variables.scss", "Import rule set for variables in  SASS sub-directory to _WebBlocks-variables.scss"
    assert_file_has_import_rule tmp_sass_lib_file, tmp_sass_lib_file_variables, "Import rule set for _WebBlocks-variables.scss file into _WebBlocks.scss file"
    assert_file_has_import_rule tmp_sass_lib_file, tmp_sass_lib_file_require, "Import rule set for _WebBlocks-require.scss file into _WebBlocks.scss SASS file"
    assert_file_has_import_rule tmp_sass_lib_file_ie, tmp_sass_lib_file_variables, "Import rule set for _WebBlocks-variables.scss file into _WebBlocks-ie.scss file"
    
  end
  
  def test_compile_css
    
    config[:src][:sass][:dir] = "#{File.dirname(Pathname.new(__FILE__).realpath)}/WebBlocks/src/sass"
    
    execute 'preprocess_css'
    execute 'link_css'
    execute 'compile_css'
    
    assert_file_exists "#{tmp_css_build_dir}/compiled", "Compile generated css/compiled folder"
    assert_file_exists "#{tmp_css_build_dir}/compiled/blocks.css", "Compile generated blocks.css file from blocks.scss"
    assert_file_exists "#{tmp_css_build_dir}/compiled/blocks-ie.css", "Compile generated blocks-ie.css file from blocks-ie.scss"
    assert_file_exists "#{tmp_css_build_dir}/compiled/other.css", "Compile generated other.css file from other.scss"
    
    assert_file_has_css_selector "#{tmp_css_build_dir}/compiled/blocks.css", "src_sass_blocks", "Proper compiled contents from SASS file"
    assert_file_has_css_selector "#{tmp_css_build_dir}/compiled/blocks-ie.css", "src_sass_blocks-ie", "Proper compiled contents from IE SASS file"
    assert_file_has_css_selector "#{tmp_css_build_dir}/compiled/other.css", "src_sass_other", "Proper compiled contents from SASS file"
    
  end
  
  def test_assemble_css
    
    config[:src][:sass][:dir] = "#{File.dirname(Pathname.new(__FILE__).realpath)}/WebBlocks/src/sass"
    config[:src][:css][:dir] = "#{File.dirname(Pathname.new(__FILE__).realpath)}/WebBlocks/src/css"
    
    execute 'preprocess_css'
    execute 'link_css'
    execute 'compile_css'
    execute 'assemble_css'
    
    assert_file_has_css_selector tmp_css_build_file, "src_sass_blocks", "Compiled CSS files are assembled"
    assert_file_has_css_selector tmp_css_build_file, "src_sass_other", "Compiled CSS files are assembled"
    assert_file_has_css_selector tmp_css_build_file, "src_sass_dir_blocks", "Compiled sub-directory CSS files are assembled"
    assert_file_has_css_selector tmp_css_build_file_ie, "src_sass_blocks-ie", "Compiled IE CSS files are assembled"
    assert_file_has_css_selector tmp_css_build_file_ie, "src_sass_dir_blocks-ie", "Compiled sub-directory IE CSS files are assembled"
    
    assert_file_has_css_selector tmp_css_build_file, "src_css_blocks", "CSS files are assembled"
    assert_file_has_css_selector tmp_css_build_file_ie, "src_css_blocks-ie", "IE CSS files are assembled"
    assert_file_has_css_selector tmp_css_build_file, "src_css_dir_blocks", "Subdirectory CSS files are assembled"
    assert_file_has_css_selector tmp_css_build_file_ie, "src_css_dir_blocks-ie", "Subdirectory IE CSS files are assembled"
    
  end
  
  def test_assemble_img
    
    config[:src][:img][:dir] = "#{File.dirname(Pathname.new(__FILE__).realpath)}/WebBlocks/src/img"
    
    execute 'preprocess_img'
    execute 'assemble_img'
    
    assert_file_exists "#{tmp_img_build_dir}/img.bmp", ".bmp image copied to temporary image build directory"
    assert_file_exists "#{tmp_img_build_dir}/img.gif", ".gif image copied to temporary image build directory"
    assert_file_exists "#{tmp_img_build_dir}/img.jpeg", ".jpeg image copied to temporary image build directory"
    assert_file_exists "#{tmp_img_build_dir}/img.jpg", ".jpg image copied to temporary image build directory"
    assert_file_exists "#{tmp_img_build_dir}/img.png", ".png image copied to temporary image build directory"
    assert_file_exists "#{tmp_img_build_dir}/dir/img.gif", "Image copied from subdirectory to temporary image build directory"
    
  end
  
  def test_assemble_js
    
    config[:src][:js] = {
      :dir  => "#{File.dirname(Pathname.new(__FILE__).realpath)}/WebBlocks/src/js",
      :core => {:dir =>'core'},
      :core_ie => {:dir =>'core-ie'}, 
      :script => {:dir => 'script'}  
    }
    
    execute 'preprocess_js'
    execute 'assemble_js'
    
    assert_file_has_js_var tmp_js_build_file, "src_js_core_1", "JS file assembled from core sources"
    assert_file_has_js_var tmp_js_build_file, "src_js_core_2", "JS file assembled from core sources"
    assert_file_does_not_have_js_var tmp_js_build_file_ie, "src_js_core_1", "No leakage from JS sources into IE JS file"
    assert_file_does_not_have_js_var tmp_js_build_file_ie, "src_js_core_2", "No leakage from JS sources into IE JS file"
    
    assert_file_has_js_var tmp_js_build_file_ie, "src_js_core_ie_1", "IE JS file assembled from core-ie sources"
    assert_file_has_js_var tmp_js_build_file_ie, "src_js_core_ie_2", "IE JS file assembled from core-ie sources"
    assert_file_does_not_have_js_var tmp_js_build_file, "src_js_core_ie_1", "No leakage from JS IE sources into JS file"
    assert_file_does_not_have_js_var tmp_js_build_file, "src_js_core_ie_2", "No leakage from JS IE sources into JS file"
    
    assert_file_exists "#{tmp_js_build_script_dir}/file.js", "JS script copied to temporary JS script build directory"
    assert_file_exists "#{tmp_js_build_script_dir}/dir/file.js", "JS script in sub-directory copied to temporary JS script build sub-directory"
    
  end
  
  def test_package_css
    
    config[:src][:sass][:dir] = "#{File.dirname(Pathname.new(__FILE__).realpath)}/WebBlocks/src/sass"
    config[:src][:css][:dir] = "#{File.dirname(Pathname.new(__FILE__).realpath)}/WebBlocks/src/css"
    
    execute 'preprocess_css'
    execute 'link_css'
    execute 'compile_css'
    execute 'assemble_css'
    
    assert_file_has_pattern tmp_css_build_file, /\/\*WHITESPACE\*\//, "Comment present in assembled CSS"
    assert_file_has_pattern tmp_css_build_file_ie, /\/\*WHITESPACE\*\//, "Comment present in assembled IE CSS"
    
    config[:build][:debug] = true
    
    execute 'package_css'
    
    assert_file_exists css_build_file
    assert_file_exists css_build_file_ie
    
    assert_file_has_pattern css_build_file, /\/\*WHITESPACE\*\//, "Comment present in packaged CSS with debug on"
    assert_file_has_pattern css_build_file_ie, /\/\*WHITESPACE\*\//, "Comment present in package IE CSS with debug on"
    
    config[:build][:debug] = false
    
    execute 'package_css'
    
    assert_file_exists css_build_file
    assert_file_exists css_build_file_ie
    
    assert_file_does_not_have_pattern css_build_file, /\/\*WHITESPACE\*\//, "Comment not present in packaged CSS with debug off"
    assert_file_does_not_have_pattern css_build_file_ie, /\/\*WHITESPACE\*\//, "Comment not present in package IE CSS with debug off"
    
  end
  
  def test_package_img
    
    execute 'preprocess_img'
    execute 'assemble_img'
    execute 'package_img'
    
    assert_file_exists "#{img_build_dir}/img.bmp", ".bmp image copied to temporary image build directory"
    assert_file_exists "#{img_build_dir}/img.gif", ".gif image copied to temporary image build directory"
    assert_file_exists "#{img_build_dir}/img.jpeg", ".jpeg image copied to temporary image build directory"
    assert_file_exists "#{img_build_dir}/img.jpg", ".jpg image copied to temporary image build directory"
    assert_file_exists "#{img_build_dir}/img.png", ".png image copied to temporary image build directory"
    assert_file_exists "#{img_build_dir}/dir/img.gif", "Image copied from subdirectory to temporary image build directory"
    
  end
  
  def test_package_js
    
    config[:src][:js] = {
      :dir  => "#{File.dirname(Pathname.new(__FILE__).realpath)}/WebBlocks/src/js",
      :core => {:dir =>'core'},
      :core_ie => {:dir =>'core-ie'}, 
      :script => {:dir => 'script'}  
    }
    
    execute 'preprocess_js'
    execute 'assemble_js'
    
    assert_file_has_pattern tmp_js_build_file, /\/\*WHITESPACE\*\//, "Comment present in assembled JS"
    assert_file_has_pattern tmp_js_build_file_ie, /\/\*WHITESPACE\*\//, "Comment present in assembled IE JS"
    assert_file_has_pattern "#{tmp_js_build_script_dir}/whitespace.js", /\/\*WHITESPACE\*\//, "Comment present in assembled scripts JS"
    
    config[:build][:debug] = true
    
    execute 'package_js'
    
    assert_file_has_pattern js_build_file, /\/\*WHITESPACE\*\//, "Comment present in packaged JS with debug on"
    assert_file_has_pattern js_build_file_ie, /\/\*WHITESPACE\*\//, "Comment present in packaged IE JS with debug on"
    assert_file_has_pattern "#{js_build_script_dir}/whitespace.js", /\/\*WHITESPACE\*\//, "Comment present in packaged scripts JS with debug on"
    
    config[:build][:debug] = false
    
    execute 'package_js'
    
    assert_file_does_not_have_pattern js_build_file, /\/\*WHITESPACE\*\//, "Comment not present in packaged JS with debug off"
    assert_file_does_not_have_pattern js_build_file_ie, /\/\*WHITESPACE\*\//, "Comment not present in packaged IE JS with debug off"
    assert_file_does_not_have_pattern "#{js_build_script_dir}/whitespace.js", /\/\*WHITESPACE\*\//, "Comment not present in packaged scripts JS with debug off"
    
  end
  
  def test_clean
    
    FileUtils.mkdir_p build_dir
    
    execute 'clean'
    
    assert_file_does_not_exist build_dir, "Build directory removed by clean"
    
  end
  
  def test_reset
    
    FileUtils.mkdir_p "#{root_dir}/.blocks"
    
    execute 'reset'
    
    assert_file_does_not_exist "#{root_dir}/.blocks", "Metadata directory removed by reset"
    
  end
  
  def assert_file_exists file, message = ''
    
    assert File.exists?(file), message
    
  end
  
  def assert_file_does_not_exist file, message = ''
    
    assert_equal false, File.exists?(file), message
    
  end
  
  def assert_file_has_pattern file, pattern, message = ''
    
    assert_not_nil (File.open(file, 'rb') { |f| f.read }).match(pattern), message
    
  end
  
  def assert_file_does_not_have_pattern file, pattern, message = ''
    
    assert_nil (File.open(file, 'rb') { |f| f.read }).match(pattern), message
    
  end
  
  def assert_file_has_css_selector file, selector, message = ''
    
    assert_file_has_pattern file, /#{Regexp.escape(selector)}\s*\{/, message
    
  end
  
  def assert_file_has_js_var file, variable, message = ''
    
    assert_file_has_pattern file, /var\s\s*#{Regexp.escape(variable)}\s*=/, message
    
  end
  
  def assert_file_does_not_have_js_var file, variable, message = ''
    
    assert_file_does_not_have_pattern file, /var\s\s*#{Regexp.escape(variable)}\s*=/, message
    
  end
  
  def assert_file_has_import_rule file, rule, message = ''
    
    assert_file_has_pattern file, /^\@import "#{Regexp.escape(rule)}";$/, message
    
  end

end