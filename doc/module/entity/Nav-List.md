# Entity/Nav/List

## Definition

Navigation organized as a vertical (or "stacked" list). This element can contain multiple list elements at the same
DOM level (considered to be "sibling sections" of each other) and lists nested within one another (considered to be
"child sections").

## Usages

* Primary or secondary navigation of a website

## Features

### Hiding/Revealing Child Lists

There are two scenarios where child lists will be hidden and displayed via an effect:

* **Accordion**: Adding the `accordion` class to the main `nav` element will cause the child lists to be hidden and
revealed underneath their parent link within the navigation
* **Flyout**: Adding the `flyout` class to the main `nav` element will cause the child lists to appear next to their
parent link (either to the left or the right, depending on the orientation of the list)

In both scenarios, the `active` class is used to denote the `li` element that contains the child list that is currently
visible.

### Multiple Lists

A `nav` element or a `li` element within the navigation can contain multiple `ul` or `ol` elements. These are considered 
"sections" of navigation. To add a divider above a "section" of navigation, add the `divider` class to the `ul` or `ol`.

### Navigation Headers

A header (`h1`...`h6`) element can be used to denote a "header" for a set of links within the list. This header element
can be placed outside a list or within a list item. When using one of the hide/reveal effects described
above, however, a parent link must be provided.

## Responsive Considerations

* This type of list will always expand to fit the full width of its containing element. In the case of the smallest
viewport size, this list would fit the full width of the screen
* The "flyout" effect will not work on smaller viewport sizes as there will not be enough space to display the menu
beside the main navigation list. Thus, the "flyout" effect will be replaced with the "accordion" effect on smaller
viewport sizes