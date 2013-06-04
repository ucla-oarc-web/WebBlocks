require 'rubygems'
require 'fileutils'
require 'extensions/kernel' if defined?(require_relative).nil?
require_relative '../../Path'
require_relative '../Submodule'
require_relative '../Utilities'
require_relative '../../Logger'

module WebBlocks
  
  module Build
    
    module Package
      
      class Opticss
        
        include ::WebBlocks::Logger
        include ::WebBlocks::Path::Build
        include ::WebBlocks::Path::Temporary_Build
        include ::WebBlocks::Build::Submodule
        include ::WebBlocks::Build::Utilities
        
        def preprocess
          
          preprocess_css
          
        end
        
        def preprocess_css
          
          if config[:build][:debug]
            log.warning "Package: OptiCSS", "Skipping OptiCSS because in debug mode"
            return
          end
          
          preprocess_submodule :opticss
          preprocess_submodule_submodules :opticss
          
        end
        
        def postprocess
          
          postprocess_css
          
        end
        
        def postprocess_css
          
          if config[:build][:debug]
            log.warning "Package: OptiCSS", "Skipping OptiCSS because in debug mode"
            return
          end
            
          with_clean_bundler_env do
              
            opticss_package_dir = package_dir :opticss

            log.task "Package: OptiCSS", "Installing OptiCSS dependencies via Bundler" do
              status, stdout, stderr = systemu "#{config[:exec][:bundler]} --gemfile \"#{opticss_package_dir}/Gemfile\""
              if stderr.length > 0
                log.failure "Package: OptiCSS", "Bundler failed to complete successfully"
              end
            end
            
            tmp_file_path = from_tmp_build_dir_to "opticss.rb"
            
            [
              {:build_file => css_build_file, :commands => config[:package][:opticss][:commands]},
              {:build_file => css_build_file_ie, :commands => config[:package][:opticss][:commands_ie]}
            ].each do |run|
              
              log.task "Package: OptiCSS", "Running OptiCSS for #{run[:build_file]}" do
              
                File.open(tmp_file_path, "w") do |io| 
                  commands = run[:commands]
                  commands.gsub! /\[\[save_file\]\]/, "\'#{run[:build_file]}\'"
                  io.write commands
                end

                cmd = "require 'rubygems'
  require '#{package_dir :opticss}/lib/Optimizer'
  OptiCSS::Optimizer.new \"#{run[:build_file]}\" do
    eval File.open(\"#{tmp_file_path}\") {|f| f.read }
  end".gsub("\"", "\\\"")

                status, stdout, stderr = systemu "ruby -e \"#{cmd.sub("\\", "\\\\")}\""

                if stderr.length > 0
                  log.failure "OptiCSS run failed" do
                    log.debug stderr
                  end
                else
                  log.info "OptiCSS ran successfully" do
                    log.debug run[:commands]
                  end
                end
              
              end
              
            end
            
          end
          
        end
        
        def clean
          
          log.task "Package: OptiCSS", "Removing build split_save products" do
          
            [css_build_file, css_build_file_ie].each do |file|
              dir = File.dirname file
              Dir.foreach(dir) do |item|
                next if item == '.' or item == '..'
                base = File.basename(file).gsub(/\.css$/, "")
                if !!item.match(/#{base}\-\d*\.css$/)
                  log.info "Removed #{dir}/#{item}" do
                    FileUtils.rm_rf "#{dir}/#{item}"
                  end
                end
              end
            end
          
          end
          
        end
        
        def reset_package
          
          reset_submodule :opticss
          
        end
        
      end
      
    end
    
  end
  
end