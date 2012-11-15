# Architecture

This document is intended to provide a basis of understanding for the architecture behind WebBlocks, with a focus on the WebBlocks compile process, configuration settings, and package structure.

As a note, throughout this documentation, default paths are used. However, these may not be the actual paths if they have been configured otherwise in `Rakefile-config.rb`.

## Build Files

The WebBlocks compilation process creates the following in the `build` directory:

* `css/blocks.css`
* `css/blocks-ie.css`
* `js/blocks.js`
* `js/blocks-ie.js`
* `js/scripts/`
* `img/`

## Terminology

Some general terminology useful throughout the system.

#### Package

A third-party extension checked out as a git submodule within the `/package` directory. 

Each third-party package includes a "builder" with several responsibilities:

* Managing the Git submodule
* Building the package if it does not come prebuilt
* Copying its build files into the WebBlocks temporary build region

#### Module 

A module is a definition (or set of definitions) as they reside within `/src/core/definitions`. 

For example, if one wants to build WebBlocks with just the base definitions and not the entities, they would set `WebBlocks.config[:src][:modules] = ['base']`. This will load everything under `/src/core/definitions/base`. This can be done at any granularity and the array may define as many entities as desired. Note that this is additive, so `WebBlocks.config[:src][:modules] = ['base', 'base/block']` is _superfluous_ since `base` includes `base/block`.

#### Core Definitions

This is where all of the actual WebBlocks components are defined, and it defines the modular structure for `WebBlocks.config[:src][:modules]` where whatever is set for that variable is what is included (as well as all subdirectories underneath).

The handler for the core definitions resides within `/lib/Build/Core/Definitions.rb`.

#### Adapter

A set of SASS that links WebBlocks definitions to a framework by defining mixins, generally defined as a subdirectory within `/src/adapter`. 

The default adapter is "bootstrap", although others may be written to implement WebBlocks within additional frameworks like Foundation and HTML 5 Boilerplate.

Adapters may also include Javascript, which is packaged directly into the CSS core and IE build files, as well as images, which are stored in the images directory relative to their path within the adapter.

The handlers for building adapters (beyond the rules described above) resides within `/lib/Build/Adapter/` with the same name as the adapter itself.

Note 1: Adapters are module-sensitive meaning that they should replicate the structure of the core definitions. For example, if you web `WebBlocks.config[:src][:modules] = ['base']`, adapter definitions under `entity` would not be loaded. To set up a definition that is always loaded regardless of module-sensitivity, it should be added to the _require.scss file.

Note 2: In some cases, a builder may move images and Javascript into the build directory in other ways, such as the Bootstrap adapter, which moves the glyphicons images in separately from the adapter. Such operations should be handled by the adapter build class defined in `/lib/Build/Adapter` with the same name as the adapter itself.

#### Core Adapter

This is a base set of definitions of mixins used by the core definitions, as defined in `/src/core/adapter`.

Generally, these mixins should be empty, although for basic things that are not framework-dependent (such as `base/type/align`), the mixins actually include CSS properties. When creating a new adapter, it is recommended that `/src/core/adapter` be copied into a subdirectory of `/src/adapter` and then modified to provide just the things that the adapter changes from the core adapter.

The handler for the core adapter resides within `/lib/Build/Core/Adapter.rb`.

#### Extension

A set of SASS that is loaded in that may change the behavior of mixins or specify additional CSS definitions, generally defined as a directory within `/src/extension` (although an extension may reside elsewhere if specified by absolute path in `Rakefile-config.rb`).

Extensions may also include Javascript, which is packaged directly into the CSS core and IE build files, as well as images, which are stored in the images directory relative to their path within the adapter.

Extensions are like adapters in the way they change behavior. However, instead of bridging framework to WebBlocks, they are intended to modify WebBlocks such as applying a theme or altering behaviors in some more macro way. For example, if UCLA provided a WebBlocks fork, it might create `/src/extension/ucla`.

The handler for building extensions resides within `lib/Build/Core/Extensions.rb`.

Note: Extensions are not module-sensitive, meaning that all SASS, Javascript and images are loaded regardless of a subdirectory structure.

## Build Process

The build process is extremely modular in that one may invoke not just `rake` or `rake build` to build all WebBlocks assets, but also `rake build_css`, `rake build_js` and `rake build_img` to build just CSS, JS or images. Generally, these functions should only be invokved if `rake build` or `rake` has already been called, useful for *rebuilding* just what was changed, as it will execute more quickly than re-running `rake build` or `rake` in its entirety.

### Build Execution Step

The build task itself executes several phases. The handlers for packages, the core adapter, user-defined adapters, extensions and core definitions all listen for these events and fire their method by the name of the event (if defined).

For a given task such as `compile`, one may also hook in before any handler executes the step with a `before_` method such as `before_compile` or after all handlers have executed the step with an `after_` method such as `after_compile`.

#### preprocess

Packages and adapters set up Git submodules as needed.

WebBlocks defines the temporary build directory and creates a set of linkage files including:

* `WebBlocks` which imports `WebBlocks-variables` and `WebBlocks-require`
* `WebBlocks-ie` which imports `WebBlocks-variables`
* `WebBlocks-variables`
* `WebBlocks-require`

The `WebBlocks` file should be imported by the build file (by default `/src/sass/blocks.scss`) and the `WebBlocks-ie` file should be imported by the IE build file (by default `/src/sass/blocks-ie.scss`). In both cases, they may be included by file name, so `@import "WebBlocks";` and `@import "WebBlocks-ie";`, rather than by absolute path.

#### link

Adapters define `@import` rules the linkage files `WebBlocks`, `WebBlocks-ie`, `WebBlocks-require` and `WebBlocks-variables`.

#### compile

Packages and adapters compile any sources that do not come precompiled in their Git submodules.

WebBlocks executes the Compass/SASS compiler with the linkage files `WebBlocks`, `WebBlocks-ie`, `WebBlocks-require` and `WebBlocks-variables` as library files directly in its namespace.

#### assemble

As needed, packages and adapters append Javascript and CSS into the temporary JS and CSS build files and copy images into the temporary image build directory.

WebBlocks then copies the CSS files from the `compile` step into the temporary CSS build files.

#### package

WebBlocks copies the temporary build files and directories into the final build location, minifying the CSS and Javascript if `WebBlocks.config[:build][:debug] = false` or if it is not set.

#### postprocess

A hook step in the event that any package or adapter wishes to act after WebBlocks has been packaged into the build folder (such as running an optimizer package on the CSS).

### Build Stack

All tasks (both the ones listed in build and the ones in all other Rake tasks) are delegated to handlers in the following order:

1. Packages (see `/lib/Build/Packages/`)
2. Core Adapter (see `/lib/Build/Core/Adapter.rb`)
3. User-defined Adapters  (see `/lib/Build/Adapter/`)
4. Extensions  (see `/lib/Build/Core/Extensions.rb`)
5. Core Definitions (see `/lib/Build/Core/Definitions.rb`)
6. WebBlocks (see `/lib/Build/WebBlocks.rb`)

This order is important to understand as it pertains to the order in which handlers execute for all execution setps.

This order is defined in `/lib/Rake.rb` (and handlers 2-5 further within `/lib/Build/Manager.rb`) when `run` is invoked within the `::WebBlocks::Rake` DSL.

### SASS Includes Stack

Among the build processes, the most complex portion is building the SASS includes stack.

In `src/sass/blocks.scss`, the following rule is defined:

```css
@import "WebBlocks";
```

Similarly, in `src/sass/blocks-ie.scss`, the following rule is defined:

```css
@import "WebBlocks-ie";
```

During the `link` build execution step, these files are composed so that they include all necessary SASS files based on the configuration of modules, adapters and extensions.

Generally (except if packages intervene), the order followed is:

1. Core Adapter `src/core/adapter`
2. User-Configured Adapters `src/adapter/[name]` from `WebBlocks.config[:src][:adapter]`
3. User-Configured Extensions `src/extension` from `WebBlocks.config[:src][:extensions]`
4. Core Definitions `src/core/definitions`

For this order, there are actually three phases:

1. All files with the name `_variables.scss`
2. All files with the name `_require.scss` in the module namespaces defined by `Rakefile-config.rb`
3. All other `.scss` files specified in the module namespaces defined by `Rakefile-config.rb`

Among each phase, all files are loaded in breadth-first order by each handler, meaning that if an entity extends another entity, then the entity it extends should be defined in an outer directory. Among files within the same directory, there is no guaranteed load order, so there should not be definitions that require each other located within the same directory.

Note: It may be possible to define module inclusion rules that cause the compile to fail because an inner entity was included that requires an outer mixin that was not also included, so caution should be used with `WebBlocks.config[:src][:modules]`.

### Images and Script Sources

Images and script sources (defined in `src/img` and `src/js/script`) are copied into `build/img` and `build/js/script` based on relative pathing within their respective directories. For Javascript, this behavior is notably different than sources in `js/core` and `js/core-ie`, which are appended into `blocks.js` and `blocks-ie.js` respectively. If debug is not turned on, then all Javascript sources will be minified during the package stage.