# Modules

## Overview

The WebBlocks semantics are organized in a series of modules. Each module is a 
logical subdivision that contains a number of definitions.

Top-level modules includes:

* `base` - Foundational elements that establish a grid, colors and provide 
utilities for floating, visibility, image replacement and other such things. 
This namespace should almost always be included in a WebBlocks build.
* `entity` - Common user interface elements including styled versions of 
HTML base elements elements such as lists, tables, blockquotes and buttons, as 
well as more complex elements such as headers and navs. This namespace is 
generally included in a WebBlocks build, and many of its components require the 
`base` namespace.
* `extend` - More advanced elements that enhance the user experience such as a 
scrollable table. This namespace is not always included in full, but rather 
individual modules are often selected. In many cases, elements within the 
`extend` namespace require components from the `entity` namespace to work 
correctly.

## Configuration

During the build process, these modules may be enabled or disabled through the 
`WebBlocks.config[:src][:modules]` directive. See the Configuration 
documentation for more information.

## Dependencies

At the current time, dependency management may be an issue if an included module
extends a module that was not included, as modules define the entirety of the
semantics related to an element. To deal with this problem, some guidance is
provided in the way namespaces are organized, namely that `base` should be 
included for all modules in `entity` and, for any `extend` submodule included,
the `entity` module with the same namespace structure should also be included.
In time, a dependency handler will be added to the build stack manager.

## Composition

A module is composed minimally of two components:

1. A definition in `core/definitions` that specifies the selector definition.
2. A core adapter mixin in `core/adapter` implementation that specifies the 
definitions loaded into the selector.

The purpose of this separation is to allow one to directly redefine the 
definitions loaded into the selector simply by overwriting the mixin initially
defined in the core adapter. In a way, this is similar to object-oriented
practice, although it is impossible to call the original version of the mixin
once it has been redefined, meaning that these mixins must be all-inclusive
of the definitions.

The load stack is as follows:

1. Core Adapter
2. User-defined Adapters
3. User-defined Extensions
4. Core Definitions

This means that an adapter or extension may redefine any mixin defined earlier
in the stack, though a mixin may not be defined from within `src/sass`, as
WebBlocks itself is already compiled at the point when `@import "WebBlocks";`
is called.

## Extending Modules

When working in an extension, defining elements in `src/sass`, or building a new 
module, it is highly recommended that one extends existing WebBlocks semantics
where needed rather than specifying the same set of definitions a second time.
This ensures that improvements to this baseline element will propagate to other 
elements using it.

When it is not possible to extend an element directly, then if at all possible,
try to leverage one of the mixins (found in the core adapter). This will achieve
the same effect, although it will not consolidate selectors as the `@extend`
selector does.