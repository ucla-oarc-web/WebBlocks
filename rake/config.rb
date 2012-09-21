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
  
  @config = Hash.new
  
  # build configuration
  
  @config[:build] = Hash.new
  
  @config[:build][:debug] = {
    :enabled  => false,
    :dir      => 'debug'
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
    :bootstrap,
    :jquery,
    :modernizr,
    :respond,
    :selectivizr
  ]
  
  # src configuration
  
  @config[:src] = {
    :dir      => 'src',
    :sass     => {
      :dir => 'sass'
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
    
    :modules  => :all,                # array of directories in /src/core/definitions
                                      # or false if no modules to include
                                      # or :all to include all modules
                                      
    :extensions => false              # array of additional directories in /src
                                      # or false if no additional directories to include
  }

  # executables configuration

  @config[:exec] = {
    :git        => 'git',
    :grunt      => 'node ./node_modules/grunt/bin/grunt',
    :npm        => 'npm',
    :sass       => 'sass',
    :uglifycss  => 'node ./node_modules/uglifycss/uglifycss',
    :uglifyjs   => 'node ./node_modules/uglify-js/bin/uglifyjs',
    :compass    => 'compass'
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
  
  @config[:package][:jquery] = {
    :dir        => 'jquery'
  }
  
  @config[:package][:modernizr] = {
    :dir      => 'modernizr'
  }
  
  @config[:package][:respond] = {
    :dir      => 'respond'
  }
  
  @config[:package][:selectivizr] = {
    :dir      => 'selectivizr'
  }

  # advanced configuration
  
  @config[:build][:dir_tmp] = '.build-tmp'
  @config[:build][:dir_metadata] = '.blocks'
  
  def self.config
    @config
  end

end