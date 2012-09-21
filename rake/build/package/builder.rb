require 'pathname'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/builder.rb"

module WebBlocks
  
  module Build
    
    module Package
    
      class Builder < WebBlocks::Build::Builder
        
        def dir_packages
          @config[:package][:dir]
        end

      end
    
    end
    
  end
  
end