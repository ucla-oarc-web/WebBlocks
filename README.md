# WebBlocks

## Overview

WebBlocks is a toolkit that facilitates the rapid development of responsive,
aesthetic and modern web applications. This framework integrates a number of
existing web packages and extends them with additional functionality.

## Build

#### Prerequisites

WebBlocks is built via `rake`, a Ruby build utility similar to GNU `make`. As 
such, the following are required to build WebBlocks:

* ruby
* gem
* rake

The Rakefile itself uses several additional tools:

* git
* uglifycss
* uglifyjs

Several packages have additional requirements:

* `bootstrap`: sass, rb-fsevent
* `jquery`: grunt

By default, the Rakefile execute these tools as though they are within the user
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
```

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

Some or all of these installations may require superuser privileges.

#### Building WebBlocks

WebBlocks can be built simply by invoking `rake`.

The entire process from checkout to completed build is as follows:

```
git clone git@github.com:ucla/WebBlocks.git
cd WebBlocks
rake
```

The Rakefile includes several tasks that may be invoked separately as well:

* `rake check` check for prerequisites (requires commands in user search path)
* `rake packages` update all submodule packages from their remote repositories
* `rake build` create a build of WebBlocks
* `rake clean` remove a build of WebBlocks

The default Rakefile task executes `clean -> packages -> build`.

The configuration file `Rakefile-configure.rb` may be modified to change a 
number of properties about the build including the packages, the final build
destination, and the commands for various executables.

## Credits

WebBlocks leverages a number of external packages:

* jQuery - MIT License - http://jquery.com
* Modernizr - MIT or BSD License - http://modernizr.com
* Respond.js - MIT or GPLv2 License - https://github.com/scottjehl/Respond
* Twitter Bootstrap - Apache License - http://twitter.github.com/bootstrap
* Selectivizr - MIT License - http://selectivizr.com
