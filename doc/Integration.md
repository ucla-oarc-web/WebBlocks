There are a couple primary ways that WebBlocks can be integrated into your workflow:

1. An application may include WebBlocks as a submodule and set up the Rake process via a custom configuration file so that WebBlocks builds into a web-accessible directory within the application. This is ideal for applications that seek to leverage WebBlocks but want to include their own custom SASS definitions using the SASS/Compass/Bootstrap/WebBlocks. This submodule could be the WebBlocks repository itself, or some fork of WebBlocks that is provided by an organization using method (1).
2. An organization may fork from WebBlocks itself, modify the styles to fit their organization, and then hosting a copy of the build of their fork of WebBlocks. This is particularly useful under a federated environment, where a central unit is providing style definitions for a number of applications (and possibly other units in the organization) and thus intends to use a single build for all of these definitions.

Note that once WebBlocks is released, it will also include a set of compiled source files so that they can be dropped directly into an application without having to run `rake` at all.

## Using WebBlocks as a Submodule

In the case of developing an application that uses WebBlocks specifically but does not leverage a separate hosted build of WebBlocks, the ideal way to use WebBlocks is to check it out as a submodule.

The following would set up WebBlocks as a submodule within `package/WebBlocks`:

```
mkdir package
git submodule add git@github.com:ucla/WebBlocks.git package/WebBlocks
git submodule init
git submodule update
```

The Git reference could also be a fork of WebBlocks provided by some other unit by the "Modifying WebBlocks Directly" method.

At the most basic level, one might be inclined to then modify files within the submodule explicitly. However, because of the dynamics of Git, this isn't a particularly viable strategy, as the submodule is actually a reference to another repository and thus commits in there would attempt to be pushed back to the submodule's base repository, not your own.

Instead, one should take advantage of the `--config` option made available by Rake to set a separate configuration file that allows you to set your own configuration file location that may reside outside of the package itself. 

For example, one might place a `Rakefile-config.rb` file in your repository root as `/Rakefile-config.rb`. This config file might include the following to build WebBlocks into a `/app/www/assets` directory and use a folder `/app/src` for your sources including versions of `sass/blocks.scss` and `sass/blocks-ie.scss`:

```ruby
require 'pathname'
rootdir = File.dirname(Pathname.new(__FILE__).realpath)

# The directory into which WebBlocks is built
WebBlocks.config[:build][:dir] = "#{rootdir}/app/www/assets/blocks"

# The directory where sources for the build are located
WebBlocks.config[:src][:dir] = "#{rootdir}/app/src"

# Location of WebBlocks core components (config.rb, definitions, core adapter)
WebBlocks.config[:src][:core][:dir] = "#{rootdir}/package/WebBlocks/src/core"

# Location of WebBlocks adapters
WebBlocks.config[:src][:adapters][:dir] = "#{rootdir}/package/WebBlocks/src/adapter"
```

In addition to then defining `/app/sass/blocks.scss` and `/app/sass/blocks-ie.scss` (make sure to include `@import "WebBlocks"` in your `blocks.scss` file), one may also define variables in `/app/sass/_variables.scss`) and set the adapter and loaded modules in their `/Rakefile-config.rb` file:

```ruby
WebBlocks.config[:src][:adapter]  = 'some-adapter'
WebBlocks.config[:src][:modules]  = ['core/entity/some-element', 'core/entity/another-element']
```

The reason this should be done is that one should not be modifying code within the Git submodule, but instead working from their own application-specific directory that is versioned under the application itself.

Within the configured directory `/app/src`, one may also define several other directories with files under them including `/app/src/img` for images loaded into the build, `/app/js/core` for Javascript files loaded into the `block.js` file, `/app/src/js/core-ie` for Javascript files loaded into the `blocks-ie.js`, and `/app/src/js/script` for scripts loaded into the directory `script` within the build's `js` folder.

To invoke the WebBlocks build using this configuration, one could then issue the following command:

```
cd package/WebBlocks
rake -- --config=../../Rakefile-config.rb
```

Going a step further, one might add a `Rakefile` to the application root as `/Rakefile`. This could be used to call-forward the build process to WebBlocks that hides the command-line specificity, as well as do additional application-specific tasks as follows:

```ruby
# Definitions

include Rake::DSL

class WebBlocks
  
  attr_accessor :path
    
  def initialize(path)
    @path = path
  end
  
  def rake(command = '')
    Dir.chdir @path do
        sh "rake #{command} -- --config=../../Rakefile-config.rb"
    end
  end
  
end

blocks = WebBlocks.new('package/WebBlocks')

# Tasks

task :default => [:init] do
  blocks.rake
end

task :_init do
  sh "git submodule init"
  sh "git submodule update"
  Dir.chdir('package/WebBlocks') do
    sh "bundle"
    sh "npm install"
  end
end

task :init => [:_init] do
  blocks.rake 'init'
end

task :build => [:_init] do
  blocks.rake 'build'
end

task :build_all => [:_init] do
  blocks.rake 'build_all'
end

task :clean => [:_init] do
  blocks.rake 'clean'
end

task :clean_packages => [:_init] do
  blocks.rake 'clean_packages'
end

task :clean_all => [:_init] do
  blocks.rake 'clean_all'
end

task :reset_packages => [:_init] do
  blocks.rake 'reset_packages'
end

task :reset => [:_init] do
  blocks.rake 'reset_packages'
end
```

## Modifying WebBlocks Directly

In working to directly modify WebBlocks, it is highly recommended that an institution leverage Git, because it simplifies the ability to upgrade WebBlocks without a lot of manual work.

To get started creating a fork, one may use the following Bash commands (Windows may vary slightly):

```
mkdir your-framework
cd your-framework
git init
git remote add WebBlocks git@github.com:ucla/WebBlocks.git
git remote add origin git@github.com:your-org/your-app.git # replace your-org and your-app as needed
git pull WebBlocks master
git push -u origin master
```

When modifications are made, updates should then be pushed to origin.

```
git push origin
```

To add CSS definitions and tweak settings, one should modify the following:

* `/src/sass/blocks.scss` for styles that show up on all devices
* `/src/sass/blocks-ie.scss` for styles that should be pushed to IE up to IE 8
* `/src/sass/blocks/` for files to be included automatically by WebBlocks
* `/src/sass/_variables.scss` to set values for adapter/WebBlocks variables

For large projects, one should likely add a new directory within `/src/sass` and use `@import` definitions to include these libraries.

It is generally advised that one does not modify existing adapters within `/src/sass/adapter` or the actual entity definitions in `/src/sass/core`. New entity definitions should instead be added to a new directory within `/src/sass`. Additional adapters may be added, and this should be done by adding a new directory to `/src/sass/adapter` and then setting this adapter. In this context, extensions may also be very useful under `/src/sass/extension`.

In addition to managing SASS libraries, one may tweak build settings by setting overrides to default configuration settings in `Rakefile-config.rb`. The default settings may be found in `rake/config.rb`, but these should not be modified here, instead overriding through `Rakefile-config.rb`. One can modify a number of settings in here, including the adapter used and the modules included.