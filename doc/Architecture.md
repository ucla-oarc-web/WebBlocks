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

#### Adapter

A set of SASS that links WebBlocks definitions to a framework by defining mixins, generally defined as a subdirectory within `/src/adapter`. 

The default adapter is "bootstrap", although others may be written to implement WebBlocks within additional frameworks like Foundation and HTML 5 Boilerplate.

Adapters may also include Javascript, which is packaged directly into the CSS core and IE build files, as well as images, which are stored in the images directory relative to their path within the adapter.

Note 1: Adapters are module-sensitive meaning that they should replicate the structure of the core definitions. For example, if you web `WebBlocks.config[:src][:modules] = ['base']`, adapter definitions under `entity` would not be loaded. To set up a file that is always loaded regardless of module-sensitivity, rather than placing it in a subfolder, place it directly in the root of the adapter directory, as all folders directly under the root will be loaded.

Note 2: In some cases, a builder may move images and Javascript into the build directory in other ways, such as the Bootstrap adapter, which moves the glyphicons images in separately from the adapter.

#### Core Adapter

This is a base set of definitions of mixins used by the core definitions, as defined in `/src/core/adapter`.

Generally, these mixins should be empty, although for basic things that are not framework-dependent (such as `base/type/align`), the mixins actually include CSS properties. When creating a new adapter, it is recommended that `/src/core/adapter` be copied into a subdirectory of `/src/adapter` and then modified to provide just the things that the adapter changes from the core adapter.

#### Extension

A set of SASS that is loaded in that may change the behavior of mixins, generally defined as a directory within `/src/extension`.

Extensions may also include Javascript, which is packaged directly into the CSS core and IE build files, as well as images, which are stored in the images directory relative to their path within the adapter.

Extensions are like adapters in the way they change behavior. However, instead of bridging framework to WebBlocks, they are intended to modify WebBlocks such as applying a theme or altering behaviors in some more macro way. For example, if UCLA provided a WebBlocks fork, it might create `/src/extension/ucla`.

Note: Extensions are not module-sensitive, meaning that all SASS, Javascript and images are loaded regardless of a subdirectory structure.

## Build Process

The build process itself goes through several stages:

1. Invoke package builders to assemble third-party assets
2. Append Javascript core and core-ie source files
3. Copy and minify Javascript script source files
4. Copy image source files
5. Generate SASS includes stack
6. Run Compass compiler on SASS sources
7. Append CSS sources to SASS build
8. Copy built files from temporary build region to build directory

This process is managed through the `Rakefile`, with a large portion of it relegated to `WebBlocks::Build::Blocks` (as defined in `rake/build/blocks.rb`). It is also evident in part through stdout when invoking `rake` and in full by consulting the `build.log` file produced after a build occurs.

### SASS Includes Stack

Among the build processes, the most complex portion is building the SASS includes stack.

In `src/sass/blocks.scss`, the following rule is defined:

```css
@import "WebBlocks";
```

When the WebBlocks compiler runs, before it runs the Compass/SASS compiler, it creates a file `_WebBlocks.scss` that includes SASS files based on the configuration of modules, adapters and extensions. The build stack follows this order:

1. Core Adapter `src/core/adapter`
2. User-Configured Adapters `src/adapter/[name]` from `WebBlocks.config[:src][:adapter]`
3. User-Configured Extensions `src/extension` from `WebBlocks.config[:src][:extensions]`
4. Core Definitions `src/core/definitions`

Across this build stack, the actual import chain is done in two phases:

1. Files names `_variables.scss` and `variables.scss` are loaded first. By convention, these should not include any definitions, but rather should simply specify variables to load. All files bearing these names, regardless of the module they reside within, are imported.
2. All other files ending in `.scss`, including the modules specified for the core adapter, user-configured adapters, and core definitions, and including all `.scss` files in user-configured extensions.

All files are loaded in breadth-first order, meaning that if an entity extends another entity, then the entity it extends should be defined in an outer directory.

Note that it may be possible to define module inclusion rules that cause the compile to fail because an inner entity was included that requires an outer mixin that was not also included, so caution should be used with `WebBlocks.config[:src][:modules]`.

### Images and Script Sources

Images and script sources (defined in `src/img` and `src/js/script`) are copied into `build/img` and `build/js/script` based on relative pathing within their respective directories. For Javascript, this behavior is notably different than sources in `js/core` and `js/core-ie`, which are appended into `blocks.js` and `blocks-ie.js` respectively.

## Build Objects

While WebBlocks uses a number of objects in it's build process, all located within the `/rake` directory, this section focuses on those that are used directly rather than simply inherited from. For documentation on the other objects, please see comments inline within their respective files.

### WebBlocks::Builder

This class manages the builders for WebBlocks including both the Blocks builder and builders for various packages. The `Rakefile` interfaces with the builders that this object manages by invoking the `blocks` and `packages` accessors. The `blocks` accessor returns a `WebBlocks::Build::Blocks` and the `packages` accessor returns a traversable set of package builders.

Each of the managed builders _may_ respond to a number of methods:

* init
* init?
* build_setup (blocks only)
* compile (package only)
* build
* build_cleanup (blocks only)
* built?
* clean
* reset

The `Rakefile` is responsible for checking if a builder responds to a method before invoking it.

Defined in `rake/builder.rb`.

### WebBlocks::Build::Blocks

This builder is used to actually build WebBlocks as mediated through the `WebBlocks::Builder` build manager.

This builder responds to the following methods:

* __init__ Creates the metadata directory
* __init?__ True if the metadata directory exists
* __build_setup__ Creates the temporary build region
* __build__ Runs the blocks compiler, manages compiled outputs and moves build to the build targets
* __build_cleanup__ Removes the temporary build region
* __built?__ True if the build directory exists
* __clean__ Removes the build directory
* __reset__ Removes the build directory and the metadata directory

In the case of the `build` method, this builder is assumed to be invoked after the package builders, as it is responsible for taking all CSS, JS, and images and placing them in their final build locations after it invokes the `WebBlocks::Build::Blocks::Compiler` to generate CSS from the SASS files.

Defined in `rake/build/blocks.rb`.

### WebBlocks::Build::Blocks::Compiler

The blocks compiler is responsible for actually compiling the WebBlocks sources.

To accomplish this, it goes through several stages in the `compile` method:

1. Append Javascript core and IE sources to the Javascript core and IE build targets
2. Copy Javascript script sources to the Javascript script directory build target
3. Copy image sources to the image directory build target
4. Create the SASS import file (using `WebBlocks::Build::Adapter::Compiler` and extended classes)
5. Run the Compass compiler using the SASS import file
5. Copy CSS sources to the CSS directory build target

The most complex portion of this is the generation of the `_WebBlocks.scss` SASS file that includes `@import` rules for SASS files defined in the core adapter, user-configured adapters, user-configured extensions, and the core definitions, following module specificity rules except for the extensions. For user-configured adapters, it may leverage child classes of `WebBlocks::Build::Adapter::Compiler` if they are defined for the adapter(s) in question. Otherwise, it will use `WebBlocks::Build::Adapter::Compiler` directly with default behaviors.

Defined in `rake/build/blocks.rb`.

### WebBlocks::Build::Adapter::Compiler

The adapter compiler is used by the core adapter, user-configured adapters that don't have their own class defined under `rake/build/adapter`, and the core definitions. 

The primary method here is `included_adapter_module_files modules, ext`, which returns a list of all files matching the extension(s) specified by ext under the following conditions:

1. Include file if it is a _variables.scss or variables.scss file (when `ext == "scss"` or `ext.includes? "scss"`)
2. Include file if it is in the global namespace (not in a subdirectory)
3. Include file if it is within a module namespace (specified as a relative path in the `modules` array)

In some ways, the name "compiler" here is actually incorrect, as the real purpose of this is more similar to a linker, determining which files should be included in the SASS import file created by `WebBlocks::Build::Blocks::Compiler`.

Defined in `rake/build/adapter/compiler.rb`.

### WebBlocks::Build::Package::Builder

As opposed to the other objects in this section, `WebBlocks::Build::Package::Builder` is not actually intended to be instantiated directly but rather should be extended by a package builder `WebBlocks::Build::Package::Name` for the package called `name`.

As such, the `WebBlocks::Build::Package::Builder` does not actually define the package methods but rather helpers:

* `manage_submodule module_name, module_path` init and update the Git submodule
* `reset_submodule module_name, module_path` delete the submodule directory

The methods that can be implemented for a package builder that extends this:

* `init` any initialization that must occur
* `build` call `manage_submodule` and copy sources to build region (required)
* `clean` remove any lingering build products such as a compilation if the package required it
* `reset` call `reset_submodule`

Defined in `rake/build/package/builder.rb`.