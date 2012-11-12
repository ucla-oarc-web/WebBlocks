require 'rubygems'
require 'rake'
require 'extensions/kernel'

require 'pathname'
require 'fileutils'
require 'optparse'

require_relative 'Config'
require_relative 'Logger'
require_relative 'Rake/Manager'
require_relative 'Build/Dispatcher'
require_relative 'Build/Manager'

module WebBlocks
  
  module Rake
    
    # include DSL: Rake
    include ::Rake::DSL
    
    # include variable: config
    include ::WebBlocks::Config
    
    # include variable: log
    include ::WebBlocks::Logger
    
    # include methods: define_task, define_tasks
    include ::WebBlocks::Rake::Manager
    
    # include methods: observer, execute
    include ::WebBlocks::Build::Dispatcher
    
    # include methods: attach_packages, attach_adapters, attach_webblocks
    include ::WebBlocks::Build::Manager
    
    def run
      
      attach_packages
      attach_adapters
      attach_webblocks
      
      define_tasks
      
    end
    
  end
  
end