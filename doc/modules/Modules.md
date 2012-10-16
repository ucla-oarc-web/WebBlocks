# Modules

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

During the build process, these modules may be enabled or disabled through the 
`WebBlocks.config[:src][:modules]` directive. See the Configuration 
documentation for more information.