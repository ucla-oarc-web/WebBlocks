require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative '../../lib/Test.rb'

class TestModulesCoreAdapter < ::Test::Unit::TestCase
  
  include ::WebBlocks::Test::Unit::TestCase
  
  def setup_test
    WebBlocks.config[:src][:adapter] = false
  end
  
  def execute_module_compile_css mod
    config[:src][:modules] = mod
    assert_nothing_raised(RuntimeError) do
      execute "preprocess_css"
      execute "link_css"
      execute "compile_css"
    end
  end
  
  def test_dependency_base
    execute_module_compile_css 'base'
  end
  
  def test_dependency_base_block_float
    execute_module_compile_css 'base/block/float'
  end
  
  def test_dependency_base_color_text
    execute_module_compile_css 'base/color/text'
  end
  
  def test_dependency_base_color_background
    execute_module_compile_css ['base/color/branding/background','base/color/mood/background']
  end
  
  def test_dependency_base_color_background_gradient
    execute_module_compile_css ['base/color/branding/background_gradient','base/color/mood/background_gradient']
  end
  
  def test_dependency_base_color_background_light
    execute_module_compile_css ['base/color/branding/background_light','base/color/mood/background_light']
  end
  
  def test_dependency_base_color_background_light_gradient
    execute_module_compile_css ['base/color/branding/background_light_gradient','base/color/mood/background_light_gradient']
  end
  
  def test_dependency_base_structure
    execute_module_compile_css 'base/structure'
  end
  
  def test_dependency_base_structure_container
    execute_module_compile_css 'base/structure/container'
  end
  
  def test_dependency_base_structure_grid
    execute_module_compile_css 'base/structure/grid'
  end
  
  def test_dependency_base_structure_panel
    execute_module_compile_css 'base/structure/panel'
  end
  
  def test_dependency_base_structure_row
    execute_module_compile_css 'base/structure/row'
  end
  
  def test_dependency_base_type
    execute_module_compile_css 'base/type'
  end
  
  def test_dependency_base_visibility
    execute_module_compile_css 'base/visibility'
  end
  
  def test_dependency_base_visibility_media_query
    execute_module_compile_css 'base/visibility/media_query'
  end
  
  def test_dependency_base_visibility_responsive
    execute_module_compile_css 'base/visibility/responsive'
  end
  
  def test_dependency_entity
    execute_module_compile_css 'entity'
  end
  
  def test_dependency_entity_blockquote
    execute_module_compile_css 'entity/blockquote'
  end
  
  def test_dependency_entity_button
    execute_module_compile_css 'entity/button'
  end
  
  def test_dependency_entity_button_a_button
    execute_module_compile_css 'entity/button/_a_button'
  end
  
  def test_dependency_entity_form
    execute_module_compile_css 'entity/form'
  end
  
  def test_dependency_entity_header_masthead
    execute_module_compile_css 'entity/header/masthead'
  end
  
  def test_dependency_entity_img
    execute_module_compile_css 'entity/img'
  end
  
  def test_dependency_entity_group
    execute_module_compile_css 'entity/group'
  end
  
  def test_dependency_entity_list
    execute_module_compile_css 'entity/list'
  end
  
  def test_dependency_entity_message
    execute_module_compile_css 'entity/message'
  end
  
  def test_dependency_entity_nav_bar
    execute_module_compile_css 'entity/nav/bar'
  end
  
  def test_dependency_entity_nav_breadcrumb
    execute_module_compile_css 'entity/nav/breadcrumb'
  end
  
  def test_dependency_entity_nav_list
    execute_module_compile_css 'entity/nav/list'
  end
  
  def test_dependency_entity_nav_main
    execute_module_compile_css 'entity/nav/main'
  end
  
  def test_dependency_entity_table
    execute_module_compile_css 'entity/table'
  end

end