# WebBlocks

## Overview

WebBlocks is a toolkit that facilitates the rapid development of responsive,
aesthetic and modern web applications. This framework integrates a number of
existing web packages and extends them with additional functionality.

## Build

#### Prerequisites

WebBlocks is built via `rake`, a Ruby build utility similar to GNU `make`. As 
such, the following are required to use WebBlocks:

* Ruby
* RubyGems
* Bundler
* Rake

The rake build file (Rakefile) also requires several tools:

* Git
* Node.js
* NPM
* SASS
* Compass
* rb-fsevent
* systemu
* uglifycss
* uglifyjs

These tools are all written in either Ruby or Node.js, and as such, both are
required (see ''Installing Prerequisites'' below). However, don't fret on this
long list of packages. Instead, simply jump down to ''Installing Prerequisites''
to see how to most easily get going with WebBlocks.

By default, the Rakefile executes these tools as though they are within the user
search path. In the event that they reside elsewhere in the file system, the 
invoking commands should be specified within `Rakefile-configure.rb`.

#### Installing Prerequisites

To install Ruby, please visit:

    http://www.ruby-lang.org/en/downloads/

If the installed package does not install RubyGems, please install it from here:

    http://rubygems.org/pages/download

With Ruby and RubyGems installed, one must then install Bundler:

```
gem install bundler
```

One you have Bundler installed, use it to install the required Ruby packages
simply by invoking `bundle` from the WebBlocks root directory:

```
bundle          # from within WebBlocks root directory
```

Several required tools are also written in Node.js. To install it, please visit:

    http://nodejs.org/

With Node.js installed, use NPM to install the required Node.js packages:

```
npm install     # from within WebBlocks root directory
```

Some or all of these installations may require superuser privileges (`sudo`).

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

This assumes that you have installed Ruby, RubyGems, Bundler, node.js and npm.

The Rakefile includes a number of subtasks that may be invoked:

* `rake build` compiles and builds WebBlocks
* `rake build_all` compiles all third-party plugins and then compiles and builds WebBlocks
* `rake clean` removes the build directory for WebBlocks
* `rake clean_packages` removes the build outputs of any packages that have a compilation step
* `rake clean_all` removes the build directory for WebBlocks and the build outputs of any packages that have a compilation step
* `rake reset_packages` removes all packages (will have to fetch again to build)
* `rake reset` removes all packages (will have to fetch again to build) and resets WebBlocks state

The following subtasks will be, but are not yet, available:

* `rake check` check for prerequisites (requires commands in user search path)
* `rake environment` display the environment configuration used by WebBlocks
* `rake paths` display paths for compile/build as configured for WebBlocks
* `rake packages` display external packages WebBlocks is configured to include
* `rake includes` display sources WebBlocks is configured to include

The WebBlocks build process is highly configurable. By default, you may define
configuration settings within `Rakefile-config.rb`. A full list of all 
properties and their default values is available within `rake/config.rb`.

In some cases, it may make sense to specify a configuration file in a different
location, such as when WebBlocks is checked out as a submodule of a larger 
project. Under these conditions, a command line argument `config` is available
to specify this path:

```
rake [command] -- --config=Rakefile-config.rb
```

## Credits

WebBlocks may leverage a number of external packages:

* jQuery - MIT License - http://jquery.com
* Modernizr - MIT or BSD License - http://modernizr.com
* Respond.js - MIT or GPLv2 License - https://github.com/scottjehl/Respond
* Twitter Bootstrap - Apache License - http://twitter.github.com/bootstrap
* Selectivizr - MIT License - http://selectivizr.com

WebBlocks also uses the following software directly within its build process:

* Ruby - http://www.ruby-lang.org
* Rubygems - http://rubygems.org
* Bundler - http://gembundler.com
* Rake - http://rake.rubyforge.org
* Node.js - http://nodejs.org
* NPM - https://npmjs.org
* SASS - http://sass-lang.com
* Compass - http://compass-style.org
* rb-fsevent - https://rubygems.org/gems/rb-fsevent
* systemu - https://rubygems.org/gems/systemu
* uglifycss - https://npmjs.org/package/uglifycss
* uglify-js - https://npmjs.org/package/uglify-js

A sincere thanks to all of these authors for making their fine work available!