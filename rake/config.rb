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
  
  @config[:build][:dir] = 'build'
  
  @config[:build][:css] = {
    :dir      => 'css',
    :name     => 'blocks.css',
    :name_ie  => 'blocks-ie.css'
  }
  
  @config[:build][:js] = {
    :dir      => 'js',
    :name     => 'blocks.js',
    :name_ie  => 'blocks-ie.js'
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
    :sass     => 'sass'
  }

  # executables configuration

  @config[:exec] = {
    :git        => 'git',
    :grunt      => 'grunt',
    :npm        => 'npm',
    :sass       => 'sass',
    :uglifycss  => 'uglifycss',
    :uglifyjs   => 'uglifyjs',
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