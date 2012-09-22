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
    
    def blocks
      unless @builder_blocks
        load "#{File.dirname(Pathname.new(__FILE__).realpath)}/build/blocks.rb"
        @builder_blocks = Build::Blocks.new @config
        puts "[INITIALIZE] #{@builder_blocks.class.name}"
      end
      @builder_blocks
    end
    
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
              puts "[INITIALIZE] #{classname}"
            rescue
              fail "[INITIALIZE ERROR] WebBlocks::Build::#{name.to_s.capitalize}"
            end
          else
            puts "[INITIALIZE SKIPPED] WebBlocks::Build::#{name.to_s.capitalize}"
          end
        end
      end
      @builder_packages
    end
    
  end
  
end