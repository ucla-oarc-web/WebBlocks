require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'
require_relative '../../Logger'

module WebBlocks
  
  module Build
    
    module Package
      
      class Alphaimagescaling
        
        include ::WebBlocks::Logger
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def assemble
          
          assemble_js
          assemble_img
          
        end
        
        def assemble_js
          
          contents = "(function(){"
          log.task "Package: AlphaImageScaling", "Copying script.js to JS IE build file" do
            file = "#{package_dir :alphaimagescaling}/script.js"
            log.debug "#{tmp_js_build_file_ie.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
            contents << File.read(file)
          end
          log.task "Package: AlphaImageScaling", "Copying invoker.js to JS IE build file" do
            file = "#{package_dir :alphaimagescaling}/invoker.js"
            log.debug "#{tmp_js_build_file_ie.gsub /^#{root_dir}\//, ''} <<- #{file.gsub /^#{root_dir}\//, ''}"
            contents << File.read(file).sub('[IMGDIR]', config[:src][:img][:dir])
          end
          contents << "})();"
          
          File.open(tmp_js_build_file_ie, "a") { |handle| handle.puts contents }
          
        end
        
        def assemble_img
          log.task "Package: AlphaImageScaling", "Copying spacer.gif image" do
            file = "#{package_dir :alphaimagescaling}/spacer.gif"
            log.debug "#{tmp_img_build_dir}/alphaimagescaling/#{File.basename file} <- #{file.gsub /^#{root_dir}\//, ''}"
            FileUtils.mkdir_p "#{tmp_img_build_dir}/alphaimagescaling"
            FileUtils.cp file, "#{tmp_img_build_dir}/alphaimagescaling/#{File.basename file}"
          end
        end
        
      end
      
    end
    
  end
  
end