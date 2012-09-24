#
# WebBlocks Build Manager
# 
# This class manages the builders for WebBlocks including both the Blocks
# builder and builders for various packages. To access these builders, which
# are lazy instantiated, invoke the instance methods blocks and packages.
# More documentation on each below.
#

require 'pathname'
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/util.rb"

module WebBlocks
  
  class Builder
    
    attr_accessor :config

    def initialize(config)
      @config = config
      @builder_blocks = false
      @builder_packages = false
    end
    
    # Returns the builder for WebBlocks itself. This builder is of the class
    # WebBlocks::Build::Blocks and resides in /rake/build/blocks.rb.
    def blocks
      unless @builder_blocks
        load "#{File.dirname(Pathname.new(__FILE__).realpath)}/build/blocks.rb"
        @builder_blocks = Build::Blocks.new @config
      end
      @builder_blocks
    end
    
    # Returns the builders for packages defined in config[:build][:packages].
    # A builder for package :name should be WebBlocks::Build::Package::Name and
    # reside in /rake/build/adapter/name.rb. If no such builder exists, then 
    # the builder will be skipped, meaning the third-party package will not be
    # utilized in the build process.
    def packages
      unless @builder_packages
        @builder_packages = []
        @config[:build][:packages].each do |name|
          file = "#{File.dirname(Pathname.new(__FILE__).realpath)}/build/package/#{name}.rb"
          if File.exists? file
            load file
            begin
              classname = eval "WebBlocks::Build::Package::#{name.to_s.capitalize}"
              @builder_packages.push(classname.new(@config))
            rescue
              fail "[INITIALIZE ERROR] WebBlocks::Build::#{name.to_s.capitalize}"
            end
          end
        end
      end
      @builder_packages
    end
    
  end
  
end