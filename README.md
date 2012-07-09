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

* uglifycss
* uglifyjs

Several packages have additional requirements:

* `bootstrap`: sass, rb-fsevent
* `jquery`: make

#### Installing Prerequisites

To install Ruby, please visit:

    http://www.ruby-lang.org/en/downloads/

Once Ruby is installed, one may install other Ruby utilities:

```
sudo gem install rake
sudo gem install rb-fsevent
sudo gem install sass
```

The JS and CSS minification tools are written in Node.js, and thus Node.js 
should be installed:

    http://nodejs.org/

Node.js comes with a package manager `npm` that can be used to install the
required tools:

```
sudo npm -g install uglifycss
sudo npm -g install uglify-js
```

In addition, GNU `make` is required in order to build jQuery. Most distributions
of *NIX include `make` by default or include it in the package manager. If your
distribution does not include it, please see http://www.gnu.org/software/make.
Mac OS X users can get `make` by installing Command Line Tools for xCode.
Several ports also exist for Windows including MinWG (http://www.mingw.org)
and GNUWin32 (http://gnuwin32.sourceforge.net/packages/make.htm).

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

* `rake check` check for prerequisites
* `rake packages` update all packages (git submodules)
* `rake build` create a build of WebBlocks
* `rake clean` remove a build of WebBlocks

The default Rakefile task executes `clean -> prereq -> packages -> build`.

A configuration file `Rakefile-configure.rb` may be modified to change the
packages included in the build, the final destination of the build, etc.


## Credits

WebBlocks leverages a number of existing packages:

* jQuery - MIT License - http://jquery.com
* Modernizr - MIT or BSD License - http://modernizr.com
* Respond.js - MIT or GPLv2 License - https://github.com/scottjehl/Respond
* Twitter Bootstrap - Apache License - http://twitter.github.com/bootstrap
* Selectivizr - MIT License - http://selectivizr.com
