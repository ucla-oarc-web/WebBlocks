# WebBlocks

## Overview

WebBlocks is a toolkit that facilitates the rapid development of responsive,
aesthetic and modern web applications. This framework integrates a number of
existing web packages and extends them with additional functionality.

## Build

#### Prerequisites

WebBlocks is built via `rake`, a Ruby build utility similar to GNU `make`. As 
such, the following are required to use WebBlocks:

* gem
* rubygems
* bundler
* rake

The rake build file (Rakefile) also requires several tools:

* git
* sass
* compass
* rb-fsevent
* uglifycss
* uglifyjs
* grunt (to package jQuery)

These tools are all written in either Ruby or Node.js, and as such, both are
required (see ''Installing Prerequisites'' below).

By default, the Rakefile executes these tools as though they are within the user
search path. In the event that they reside elsewhere in the file system, the 
invoking commands should be specified within `Rakefile-configure.rb`.

#### Installing Prerequisites

To install Ruby, please visit:

    http://www.ruby-lang.org/en/downloads/

With Ruby installed, use Bundler to install the required Ruby packages:

```
bundle          # from within WebBlocks root directory
```

Several required tools are written in Node.js. To install Node.js, please visit:

    http://nodejs.org/

With Node.js installed, use NPM to install the required Node.js packages:

```
npm install     # from within WebBlocks root directory
```

Some or all of these installations may require superuser privileges.

If Bundler and/or NPM are not viable, you can also install these packages 
individually through `gem install` and `npm install`.

#### Building WebBlocks

WebBlocks can be built simply by invoking `rake`.

The entire process from checkout to completed build is as follows:

```
git clone git@github.com:ucla/WebBlocks.git
cd WebBlocks
bundle
npm install
rake
```

Again, as a reminder, these commands may require superuser privileges.

The Rakefile includes a number of subtasks that may be invoked:

* `rake build` builds WebBlocks
* `rake build_all` updates and rebuilds all packages before building WebBlocks
* `rake clean` removes the build directory for WebBlocks
* `rake clean_all` removes build outputs for all packages and WebBlocks
* `rake check` check for prerequisites (requires commands in user search path)
* `rake packages_build` builds all packages '''(!)'''
* `rake packages_clean` removes build outputs for all packages '''(!)'''
* `rake packages_update` updates submodules for all packages '''(!)'''
* `rake init` first time call to initialize WebBlocks including submodules '''(!)'''
* `rake reset` completely reset and clean state of WebBlocks build '''(!)'''

''(!) denotes an advanced feature that should likely never be called individually''

The configuration file `Rakefile-configure.rb` may be modified to change a 
number of properties about the build including the packages, the final build
destination and the commands for various executables.

## Credits

WebBlocks leverages a number of external packages:

* jQuery - MIT License - http://jquery.com
* Modernizr - MIT or BSD License - http://modernizr.com
* Respond.js - MIT or GPLv2 License - https://github.com/scottjehl/Respond
* Twitter Bootstrap - Apache License - http://twitter.github.com/bootstrap
* Selectivizr - MIT License - http://selectivizr.com
