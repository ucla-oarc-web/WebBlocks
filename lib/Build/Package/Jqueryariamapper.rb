require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'
require_relative '../../Logger'

module WebBlocks

  module Build

    module Package

      class Jqueryariamapper

        include ::WebBlocks::Logger
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities

        def init

          init_js

        end

        def init_js

          config[:src][:modules] << 'package/jqueryariamapper/binding' unless config[:src][:packages].include?('package') or config[:src][:packages].include?('package/jqueryariamapper') or config[:src][:packages].include?('package/jqueryariamapper/binding')

        end

        def preprocess

          preprocess_js

        end

        def preprocess_js

          preprocess_submodule :jqueryariamapper

        end

        def link

          link_js

        end

        def link_js

          unless ['package','package/jquery-aria-mapper'].keep_if(){ |k|
            WebBlocks.config[:src][:modules].include? k
          }.length > 0
            WebBlocks.config[:src][:modules] << 'package/jquery-aria-mapper'
          end

        end

        def assemble

          assemble_js

        end

        def assemble_js

          files = []
          files << "jQuery.ariaMapperHelper.js"
          files << "jQuery.ariaMapper.js"

          files.each do |file|
            log.task "Package: jQueryAriaMapper", "Copying #{file} to JS build file" do
              file = "#{package_dir :jqueryariamapper}/#{file}"
              log.debug "#{tmp_js_build_file.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
              append_file file, tmp_js_build_file, ';'
            end
          end

        end

        def reset_package

          reset_submodule :jqueryariamapper

        end

      end

    end

  end

end