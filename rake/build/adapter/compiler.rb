require 'pathname'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/compiler.rb"
load "#{File.dirname(File.dirname(File.dirname(Pathname.new(__FILE__).realpath)))}/util.rb"

module WebBlocks
  
  module Build
    
    module Adapter
    
      class Compiler < WebBlocks::Build::Compiler
        
        attr_accessor :path
        attr_accessor :dir_src_adapters
        attr_accessor :dir_src_adapter
        
        def initialize config, name = false
          name = self.class.name.sub(/^.*::/, '').downcase unless name
          super config
          @dir_src_adapters = WebBlocks::Util.dir_from_dir_stack dir_src, @config[:src][:adapters][:dir]
          @dir_src_adapter = WebBlocks::Util.dir_from_dir_stack @dir_src_adapters, name
        end
        
        # Generates an absolute path under the adapter or returns false if the
        # path does not exist
        def dir_src_module_definition path
          WebBlocks::Util.dir_from_dir_stack @dir_src_adapter, path
        end
        
        # Returns all files of type ext within the adapter root. This should
        # likely be foregone in favor of included_adapter_module_files, which
        # takes a parameter to control which modules should be loaded.
        def included_adapter_files ext
          get_files @dir_src_adapter, ext
        end
        
        # Returns files of the following:
        # 
        # => all files named variables.scss or _variables.scss
        #       (should not have CSS or SASS definitions)
        #       
        # => all files that reside in the root of the adapter directory
        #       (intended as global non-namespaced includes and helpers)
        #       
        # => resides within one of the paths in modules
        #       (either in folder by mod name or as file with mod name and ext)
        #
        # Override this for an individual module compiler to control different 
        # behaviors for which files to include for a given set of modules.
        def included_adapter_module_files modules, ext
          
          # adapter should be organized as a set of 
          module_paths = []
          modules.each do |mod|
            module_paths.push "#{@dir_src_adapter}\/#{mod}"
          end
          
          files = []
          included_adapter_files(ext).each do |file|
            
            # include file if it is a _variables.scss or variables.scss file
            if file.match /.*\/_variables.scss$/ or file.match /.*\/variables.scss$/
              files.push file 
              
            # include file if it is in the global namespace
            elsif !file.sub(/^#{@dir_src_adapter}\//, "").match('/')
              files.push file
              
            # include file if it is within a module namespace
            else
              module_paths.each do |module_path|
                files.push file if file.match /^#{module_path}\/.*/ or file.match /^#{module_path}\..*/
              end
            end
            
          end
          
          files
          
        end

      end
    
    end
    
  end
  
end