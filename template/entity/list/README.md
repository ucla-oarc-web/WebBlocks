# List

## Definition

A list of items, either ordered or unordered. The list elements (`ul` and `ol`) are used in a number of other
prototypes given their semantic value, but this prototype refers specifically to lists used outside other prototypes.
To apply WebBlocks styling, the element must be defined as `.list`.

## Usages

* Provide a list of items

## Features

The `.unstyled` class can be added to a list to remove the default margin, padding, and bullets (or numbering). Child
lists will not be affected.

The `.lower-roman`, `.upper-roman`, `.lower-alpha`, `.upper-alpha` classes can be added to the list to change the
list style type.

## Responsive Considerations

* This type of list will always expand to fit the full width of its containing element. In the case of the smallest
viewport size, this list would fit the full width of the screen