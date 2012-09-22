require 'pathname'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/compiler.rb"
load "#{File.dirname(File.dirname(File.dirname(Pathname.new(__FILE__).realpath)))}/util.rb"

module WebBlocks
  
  module Build
    
    module Adapter
    
      class Compiler < WebBlocks::Build::Compiler
        
        attr_accessor :path
        
        def initialize config, name = false
          name = self.class.name.sub(/^.*::/, '').downcase unless name
          super config
          @dir_src_adapters = WebBlocks::Util.dir_from_dir_stack dir_src, @config[:src][:adapters][:dir]
          @dir_src_adapter = WebBlocks::Util.dir_from_dir_stack @dir_src_adapters, name
        end
        
        def included_adapter_files ext
          get_files @dir_src_adapter, ext
        end

      end
    
    end
    
  end
  
end