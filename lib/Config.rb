#
# WebBlocks Default Build Configuration File
# 
# Do not modify this file directly.
# 
# One may specify configuration properties by specifying a configuration file
# via command line as follows:
# 
#   rake [command] -- --config=Rakefile-config.rb
#   
# If no --config is specified, then Rakefile-config.rb is used by default.
#

module WebBlocks
  
  module Config
    
    def config

      # Get config custom settings if not already loaded
      unless ::WebBlocks.config[:loaded]
        
        # Parse the --config option if specified
        options = {}
        OptionParser.new do |opts|
          opts.banner = "Usage: rake [options]"
          options[:config] = false
          opts.on( '-c', '--config [OPT]', "Config file location" ) do |filename|
            options[:config] = filename || false
          end
          options[:offline] = false
          opts.on('--offline', '--offline', 'Offline mode for fast recompile') do
            options[:offline] = true
          end
          options[:silent] = false
          opts.on('--silent', '--silent', 'Print no output except errors during compile') do
            options[:silent] = true
          end
          options[:details] = false
          opts.on('--details', '--details', 'Show compile process details') do
            options[:details] = true unless options[:silent]
          end
          options[:timing] = false
          opts.on('--timing', '--timing', 'Show compile timing telemetry') do
            options[:timing] = true unless options[:silent]
          end
        end.parse!

        # Load the configuration file, either Rakefile-config.rb or as specified by
        # the command-line argument --config
        load ::WebBlocks::Path.from_root_to options[:config] ? options[:config] : 'Rakefile-config.rb'
        
        ::WebBlocks.config[:loaded] = true
        ::WebBlocks.config[:options] = options
      
      end
      
      ::WebBlocks.config

    end
    
  end
  
  @config = Hash.new
  
  # build configuration
  
  @config[:build] = Hash.new
  
  @config[:build][:debug] = false
  
  @config[:build][:log] = {
    :name => 'build.log'
  }
  
  @config[:build][:dir] = 'build'
  
  @config[:build][:css] = {
    :dir      => 'css',
    :name     => 'blocks.css',
    :name_ie  => 'blocks-ie.css'
  }
  
  @config[:build][:js] = {
    :dir                => 'js',
    :name               => 'blocks.js',
    :name_ie            => 'blocks-ie.js',
    :name_script_dir    => 'script'
  }
  
  @config[:build][:img] = {
    :dir      => 'img'
  }
  
  @config[:build][:packages] = [
    :jquery,
    :matchMedia,
    :respond,
    :selectivizr,
    :modernizr,
    :picturefill,
    :efx,
  # :opticss, # experimental: use with caution
  ]
  
  # src configuration
  
  @config[:src] = {
    :dir      => 'src',
    :sass     => {
      :dir => 'sass',
      :includes => {
        :dir => 'includes'
      }
    },
    :css      => {
      :dir => 'css'
    },
    :img      => {
      :dir => 'img'
    },
    :js       => {
      :dir  => 'js',
      :core => {
        :dir => 'core',               # directory packaged into blocks.js
      },
      :core_ie => {
        :dir => 'core-ie'             # directory packaged into blocks-ie.js
      }, 
      :script => {
        :dir => 'script'              # directory of standalone scripts
      }  
    },
    
    :adapters => {
      :dir => 'adapter'
    },
    
    :extension => {
      :dir => 'extension'
    },
    
    :core => {
      :dir => 'core',
      :compass => {
        :config => 'config.rb'
      },
      :definitions => {
        :dir => 'definitions'
      },
      :adapter => {
        :dir => 'adapter'
      }
    },
    
    :adapter  => 'bootstrap',         # name of directory in /src/adapter or false
    
    :modules  => [
                  'base',             # array of directories in /src/core/definitions
                  'compatibility',    # or false if no modules to include
                  'entity',           # or :all to include all modules
                  
                  ###############
                  
                  # temporary until semantics around .emphasize and .fade are finalized
                  'extend/base/color/branding/background_emphasize',
                  'extend/base/color/branding/background_fade',
                  'extend/base/color/mood/background_emphasize',
                  'extend/base/color/mood/background_fade',
                  
                  ],          
                                      
    :extensions => []                 # array of additional directories in /src
                                      # or false if no additional directories to include
  }

  # executables configuration

  @config[:exec] = {
    :git        => 'git',
    :grunt      => 'node ./node_modules/grunt/bin/grunt --force',
    :npm        => 'npm',
    :sass       => 'sass',
    :uglifycss  => 'node ./node_modules/uglifycss/uglifycss',
    :uglifyjs   => 'node ./node_modules/uglify-js/bin/uglifyjs',
    :compass    => 'compass',
    :bundler    => 'bundle'
  }
  
  # package configuration
  
  @config[:package] = Hash.new
  
  @config[:package][:dir] = 'package';
  
  @config[:package][:bootstrap] = {
    :dir      => 'sass-twitter-bootstrap',
    :scripts  => [
      'dropdown',
      'button',
      'collapse',
      'alert'
    ]
  }
  
  @config[:package][:alphaimagescaling] = {
    :dir      => 'alphaimagescaling'
  }
  
  @config[:package][:adaptiveimages] = {
    :pixel_density  => true
  }
  
  @config[:package][:httpclienthints] = {
    :dir      => 'http-client-hints'
  }
  
  @config[:package][:efx] = {
    :dir      => 'efx'
  }
  
  @config[:package][:fitvids] = {
    :dir      => 'fitvids'
  }
  
  @config[:package][:jquery] = {
    :dir      => 'jquery'
  }

  @config[:package][:jqueryariamapper] = {
    :dir      => 'jquery-aria-mapper'
  }
  
  @config[:package][:lettering] = {
    :dir      => 'lettering'
  }
  
  @config[:package][:matchMedia] = {
    :dir              => 'matchMedia',
    :include_listener => true
  }
  
  @config[:package][:modernizr] = {
    :dir      => 'modernizr'
  }
  
  @config[:package][:picturefill] = {
    :dir      => 'picturefill'
  }
  
  @config[:package][:respond] = {
    :dir      => 'respond'
  }
  
  @config[:package][:selectivizr] = {
    :dir      => 'selectivizr'
  }
  
  @config[:package][:srcset] = {
    :dir      => 'srcset'
  }
  
  @config[:package][:opticss] = {
    :dir         => 'opticss',
    :commands    => "split_save [[save_file]]",
    :commands_ie => "split_save [[save_file]]"
  }

  # advanced configuration
  
  @config[:build][:dir_tmp] = '.build-tmp'
  @config[:build][:dir_metadata] = '.blocks'
  
  def self.config
    @config
  end

end