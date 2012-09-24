require 'pathname'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Bootstrap < Builder
        
        def dir_package
          generate_dir_package @config[:package][:bootstrap][:dir]
        end
        
        # TODO: Copy Bootstrap images and Javascript into temp build dir
        
        # Deletes the submodule
        def reset
          reset_submodule 'Bootstrap', dir_package
        end

      end
    
    end
    
  end
  
end