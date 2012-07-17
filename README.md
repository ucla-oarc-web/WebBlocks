# WebBlocks

## Overview

WebBlocks is a toolkit that facilitates the rapid development of responsive,
aesthetic and modern web applications. This framework integrates a number of
existing web packages and extends them with additional functionality.

## Build

#### Prerequisites

WebBlocks is built via `rake`, a Ruby build utility similar to GNU `make`. As 
such, the following are required to use WebBlocks:

* ruby
* gem
* rubygems
* bundler
* rake

The Rakefile itself requires several additional tools:

* git
* sass
* compass
* rb-fsevent
* uglifycss
* uglifyjs
* grunt (to package jQuery)

By default, the Rakefile executes these tools as though they are within the user
search path. In the event that they reside elsewhere in the file system, the 
invoking commands should be specified within `Rakefile-configure.rb`.

#### Installing Prerequisites

To install Ruby, please visit:

    http://www.ruby-lang.org/en/downloads/

Once Ruby is installed, one may install other Ruby utilities:

```
gem install rake
gem install rb-fsevent
gem install sass
gem install compass
```

It is also possible to install these by issuing the `bundle` command.

The JS and CSS minification tools are written in Node.js, and thus Node.js 
should be installed:

    http://nodejs.org/

Node.js comes with a package manager `npm` that can be used to install the
required tools:

```
npm -g install grunt
npm -g install uglifycss
npm -g install uglify-js
```

It is also possible to install these by issuing the `npm install` command.

Some or all of these installations may require superuser privileges.

#### Building WebBlocks

WebBlocks can be built simply by invoking `rake`.

The entire process from checkout to completed build is as follows:

```
git clone git@github.com:ucla/WebBlocks.git
cd WebBlocks
rake
```

The Rakefile includes a number of subtasks that may be invoked:

* `rake build` builds WebBlocks
* `rake build_all` updates and rebuilds all packages before building WebBlocks
* `rake clean` removes the build directory for WebBlocks
* `rake clean_all` removes build outputs for all packages and WebBlocks
* `rake check` check for prerequisites (requires commands in user search path)
* `rake packages_build` builds all packages
* `rake packages_clean` removes build outputs for all packages
* `rake packages_update` updates submodules for all packages

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
