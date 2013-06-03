# 
# WebBlocks Build Configuration File
# 
# This file may be used to override the default WebBlocks build configuration.
# 
# Some common configuration properties include...
#   
#   Debug mode:
#   
#     WebBlocks.config[:build][:debug]    = true or false
# 
#   Custom build directory:
#
#     WebBlocks.config[:build][:dir]      = 'build'
#     
#   Adapters:
#   
#     WebBlocks.config[:src][:adapter]    = 'bootstrap' or ['bootstrap', ...] or false
#     
#   Modules: 
#   
#     WebBlocks.config[:src][:modules]    = ['base', 'compatibility', 'entity', ...]
#     
#   Extensions:
#   
#     WebBlocks.config[:src][:extensions] = 'org' or ['org', ...]
#     
#   Packages 
#   
#     WebBlocks.config[:build][:packages] = [:jquery, :modernizr, :respond, :selectivizr, :efx]
#
# This file may also reside elsewhere in your filesystem, in which case Rake 
# should be passed a command-line property on invocation:
#
#   rake [command] -- --config=Rakefile-config.rb
#
# A full list of configurable attributes and their default values may be found 
# at http://ucla.github.io/WebBlocks/doc/#Configuration under the "Compiler" 
# section.
#
