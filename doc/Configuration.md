# Configuration

The following describe the configuration settings available to the build.

All configuration settings have defaults defined in `rake/config.rb`. However, any of these can be changed by setting them explicitly in `Rakefile-config.rb` or in some other file that is passed to `rake` via a command-line argument as `rake -- --config=[PATH]`.

## Organization

The general configuration components are as follows:

* `WebBlocks.config[:build]` - Settings related to the build produced by `rake` through `WebBlocks::builder`.
* `WebBlocks.config[:src]` - Settings related to the sources built by `WebBlocks::compiler`.
* `WebBlocks.config[:exec]` - Paths for the various executables used by WebBlocks
* `WebBlocks.config[:package]` - Settings related to third-party packages locations and builds

## Basic Configuration Settings

The following settings are ones that are anticipated to be used in general day-to-day development and integration of WebBlocks:

```ruby
# location of the build directory relative to WebBlocks root
WebBlocks.config[:build][:dir] = 'build'

# array of directories in the core definitions directory
# or :all to include all modules or false to include no modules
WebBlocks.config[:src][:modules] = :all

# the adapter or set of adapters as an array that are loaded in FIFO order 
# or false for no adapters
WebBlocks.config[:src][:adapter] = 'bootstrap'

# an array of extensions that are loaded in FIFO order or false for no extensions
WebBlocks.config[:src][:extensions] = false

# which third-party packages are included in the build
WebBlocks.config[:build][:packages] = [
    :jquery,
    :bootstrap,
    :modernizr,
    :respond,
    :selectivizr
  ]
```

## Troubleshooting Configuration Settings

Several settings exist mostly for trouble-shooting or handling of specific environments (such as when executables are not in the user path):

```ruby
# true to generate a debug directory inside build directory
WebBlocks.config[:build][:debug] = false

# executable path to Git
WebBlocks.config[:exec][:git] = 'git'

# executable path to Grunt
# defaults to relative path for npm module installation
WebBlocks.config[:exec][:git] = 'node ./node_modules/grunt/bin/grunt --force'

# executable path to NPM
WebBlocks.config[:exec][:npm] = 'npm'

# executable path to SASS
WebBlocks.config[:exec][:sass] = 'sass'

# executable path to Uglifycss
# defaults to relative path for npm module installation
WebBlocks.config[:exec][:uclifycss] = 'node ./node_modules/uglifycss/uglifycss'

# executable path to Uglifyjs
# defaults to relative path for npm module installation
WebBlocks.config[:exec][:uglifyjs] = 'node ./node_modules/uglify-js/bin/uglifyjs'

# executable path to Compass
WebBlocks.config[:exec][:compass] = 'compass'
```

### Integration Configuration Settings

When [[integrating WebBlocks||Integration]] into another package, the following settings may be useful:

```ruby
# the source directory where core, adapters, extensions, SASS, JS and images reside
# individual components within src can have their paths changed by other variables
# recommended for integration to set this outside WebBlocks and then set adapter 
# and core dir inside WebBlocks
WebBlocks.config[:src][:dir] = 'src'

# the directory within source directory where adapter directories reside
# absolute path supported
WebBlocks.config[:src][:adapters][:dir] = 'adapter'

# the directory within source directory where core definition and adapter directories 
# reside absolute path supported
WebBlocks.config[:src][:core][:dir] = 'core'
```

## Advanced Configuration Settings

The following settings are more advanced, likely never needing to be changed, although in some cases it may be useful hence provisions are provided as such:

```ruby
# directory within the build directory for debug
WebBlocks.config[:build][:debug][:dir] = 'debug'
# will soon be removed!

# directory within the root for temporary files involved with the build process
WebBlocks.config[:build][:dir_tmp] = '.build-tmp'

# directory within the root for metadata related to WebBlocks
WebBlocks.config[:build][:dir_metadata] = '.blocks'

# directory within build directory where CSS files are placed
WebBlocks.config[:build][:css][:dir] = 'css'

# name of primary CSS file within CSS build dir
WebBlocks.config[:build][:css][:name] = 'blocks.css' 

# name of IE CSS file within CSS build dir
WebBlocks.config[:build][:css][:name_ie] = 'blocks.css' 

# directory within build directory where JS files are placed
WebBlocks.config[:build][:js][:dir] = 'js'

# name of primary JS file within JS build dir
WebBlocks.config[:build][:js][:name] = 'blocks.js'

# name of IE JS file within JS build dir
WebBlocks.config[:build][:js][:name_ie] = 'blocks-ie.js'

# name of stand-alone scripts directory within JS build dir
WebBlocks.config[:build][:js][:name_script_dir] = 'script'

# directory within build directory where image files are placed
WebBlocks.config[:build][:img][:dir] = 'img'

# the directory within source directory where SASS files reside for build
# absolute path supported
WebBlocks.config[:src][:sass][:dir] = 'sass'

# the directory within SASS source directory where SASS files reside that will
# be included as part of the include chain
# absolute path supported
WebBlocks.config[:src][:sass][:includes][:dir] = 'blocks'

# the directory within source directory where image files reside for build
# absolute path supported
WebBlocks.config[:src][:css][:dir] = 'css'

# the directory within source directory where image files reside for build
# absolute path supported
WebBlocks.config[:src][:img][:dir] = 'img'

# the directory within source directory where JS files reside for build
# absolute path supported
WebBlocks.config[:src][:js][:dir] = 'js'

# the file name within core directory where Compass config file resides
# absolute path supported
WebBlocks.config[:src][:core][:compass][:config] = 'config.rb'

# the directory within core directory where core definition directories reside
# absolute path supported
WebBlocks.config[:src][:core][:definitions][:dir] = 'definitions'

# the directory within core directory where core adapter directories reside
# absolute path supported
WebBlocks.config[:src][:core][:adapter][:dir] = 'adapter'
```