require 'rubygems'
require 'extensions/kernel' if defined?(require_relative).nil?
require 'systemu'
require 'fileutils'
require_relative '../Path'

module WebBlocks
  
  module Build
      
    module Utilities
      
      def append_file src, dst, append = false
        contents = File.read src
        File.open dst, "a" do |handle|
          handle.puts contents
          handle.puts append if append
        end
      end
      
      # TODO: unit test
      def add_module module_name
        unless config[:src][:modules] == :all
          if config[:src][:modules].kind_of?(Array)
            config[:src][:modules] << module_name unless config[:src][:modules].include? module_name
          else
            config[:src][:modules] = [config[:src][:modules], module_name]
          end
        end
      end
      
      # Determine if file ends with ext (string or array of strings).
      def file_ext? file, ext
        return true unless ext
        ext = ext.join '|' if ext.respond_to? :join
        file.match(/.*\.(#{ext})$/)
      end

      # Determine if the file is an SCSS file.
      def file_scss? file
        file_ext? file, 'scss'
      end

      # Determine if the file is a JS file.
      def file_js? file
        file_ext? file, 'js'
      end

      # Get a list of all files within the directory specified as dir. If ext is
      # provided (as a string or an array of strings), then it will only return
      # files matching that extension. Unless recursive is set false, this will
      # recursively search all subdirectories for matching files as well. Files
      # are returned in a context that is absolute relative to dir. Note that
      # this function recursively iterates in breadth-first order.
      def get_files dir, ext = false, recursive = true
        files = []
        begin
          subdirs = []
          # Pass 1: Files (and storing directories for Pass 2)
          Dir.entries(dir).sort.each do |name|
            next if name[0,1] == '.'
            path = "#{dir}/#{name}"
            if File.directory? path
              subdirs.push path
            elsif file_ext? name, ext
              files.push "#{dir}/#{name}"
            end
          end
          # Pass 2: Directories
          subdirs.each do |path|
            if recursive
              get_files(path, ext, recursive).each do |sub|
                files.push sub
              end
            elsif !ext
              files.push path
            end
          end
        rescue
          []
        end
        files
      end
        
      BUNDLER_VARS = %w(BUNDLE_GEMFILE RUBYOPT BUNDLE_BIN_PATH)
      def with_clean_bundler_env
        bundled_env = ENV.to_hash
        BUNDLER_VARS.each{ |var| ENV.delete(var) }
        yield
      ensure
        ENV.replace(bundled_env.to_hash)
      end
      
    end
    
  end
  
end