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
* bundle
* rake

The Rakefile itself uses several additional tools:

* uglifycss
* uglifyjs

Several packages have additional requirements:

* bootstrap - sass, rb-fsevent
* jquery - GNU make

#### Installing Prerequisites

To install Ruby, please visit:

    http://www.ruby-lang.org/en/downloads/

Once Ruby is installed, one may install other Ruby utilities:

```
gem install bundler
gem install rake
gem install rb-fsevent
gem install sass
```

The JS and CSS minification tools are written in Node.js, and thus Node.js and
its package manager `npm` should be installed from here:

    http://nodejs.org/

Once Node.js and npm are installed, one may install  the required Node.js tools:

```
npm -g install uglifycss
npm -g install uglify-js
```

#### Building WebBlocks

WebBlocks may be built simply by invoking `rake`.

The entire process from checkout to completed build is as follows:

```
git clone git@github.com:ucla/WebBlocks.git
cd WebBlocks
rake
```

The Rakefile actually includes several separate tasks that may be invoked
individually:

* `rake prereq` check for prerequisites
* `rake build` create a build of WebBlocks
* `rake clean` remove a build of WebBlocks

The default Rakefile task executes `clean -> prereq -> build`.

A configuration file `Rakefile-configure.rb` may be modified to change the
packages included in the build, the final destination of the build, etc.


## Credits

WebBlocks leverages a number of existing packages:

* jQuery - MIT License - http://jquery.com
* Modernizr - MIT or BSD License - http://modernizr.com
* Respond.js - MIT or GPLv2 License - https://github.com/scottjehl/Respond
* Twitter Bootstrap - Apache License - http://twitter.github.com/bootstrap
* Selectivizr - MIT License - http://selectivizr.com
