# Base/Block

## Definition

This library provides several helper utilities related to block-level elements.
The classes described by this module may be used on any block-level element.

## Usages

The `Base/Block/Float` library provides helper classes that can apply a float,
clear a float, or wrap floated element(s) within a container so that elements
positioned later in the DOM will be flowed below all of the contained elements.

## Features

### Base/Block/Float

* `.float-left` applies a left float to a block
* `.float-right` applies a right float to a block
* `.float-clear` applies a clear on both right and left floats, meaning that this block will appear below floated elements above it in the DOM
* `.float-container` is a utility to wrap floated elements so that elements positioned later in the DOM will be flowed below all of the contained elements.
* `.clearfix` is an advanced version of `.float-container` that ensures containment even in scenarios where `overflow:auto` is ineffective

The `.float-container` class is preferred for most float containment scenarios.
However, there are a couple conditions where `.clearfix` is required:

1. Avoid scrollbars on containers with text that overflows due to a container's height declaration
2. Floated elements with negative margin or negative x/y positioning

## Responsive Considerations

Floated elements will be applied in all scenarios. However, many elements with
`.float-left` or `.float-right` may set `width:100%` in small viewport contexts,
in which case the float will apparently vanish in favor of a vertical arrangement
of elements.
