# Nav/Bar

## Definition

This library provides a horizontal navigational menu bar, generally located in 
the header of the page or the header of some ancillary section.

## Usages

The `Entity/Nav/Bar` modules defines the class `nav.bar` and its contained
elements, including a Javascript library that adds overflow-based 
responsiveness, dropdown support when in collapsed mode, and transparent IE9 
compatibility for border radius plus gradient.

## Features

### Header & Menu

A header element (`h1` through `h6`) can be added as the first child of `nav`
to display the title of the navigation. While this is always intended to be the
first child, the class `float-right` may be used to move the title to the right
size of the menu.

The menu itself is an un-classed `ul` or `ol` with a set of list items that 
become the menu items, arranged horizontally across the bar.

### Fixed Positioning

The `top` and `bottom` classes can be added to the `nav.bar` to create a menu
that is fixed either to the top or bottom of the viewport. When a user scrolls,
a menu with the class `top` or `bottom` will stay in its original location.

The classes `top` and `bottom` may *not* be used at the same time.

A Javascript utility also ensures that there is adequate padding to the document
body so that these elements do not obscure any site content.

### Overflow-Based Responsiveness

Typical nav bar menus collapse at some fixed breakpoint. In the case of many
menus, this behavior is non-ideal because the collapse either happens 
unnecessarily early or far after the elements have overflowed onto multiple 
lines.

This implementation takes a different approach, hiding menu items and showing
a dropdown button only when an overflow actually occurs. This is accomplished
through Javascript, and this collapse handling is done both at page load and
any time the window is resized.

### Custom Collapse Toggle and Menu

The typical configuration of `nav.bar` includes just an optional heading
element and a list. However, it is possible to set a custom collapse toggle
that one clicks on to have the menu drop down while in responsive mode, as well
as a custom menu that drops down.

To set a the custom toggle, just add a child with the class `toggle` and to set
a custom dropdown, add a child with the class `dropdown`.

### IE9 Gradient + Border Support

IE9 has a bug that does not show rounded corners on an element when a filter
is being used to generate a gradient on that element as well. The `nav.bar` 
is not rounded by default, but in the event that rounded corners are added to 
it, a transparent fix is applied for IE.

### "Active" Navigation Item

''TODO: This feature is not yet available''

To denote the "active" or "current" item in the navigation, add the "active" 
CSS class to the `li` element of the active navigation item.


### Example

```html
<nav class="bar">
    <h1>Title</h1>
    <ul>
        <li><a href="#1">Item 1</a></li>
        <li><a href="#2">Item 2</a></li>
        <li><a href="#3">Item 3</a></li>
    </ul>
</nav>
```

With a custom toggle and a custom dropdown of menu items for when the collapsed 
menu is toggled:

```html
<nav class="bar">
    <h4>Title</h4>
    <ul>
        <li><a href="#1">Item 1</a></li>
        <li><a href="#2">Item 2</a></li>
        <li><a href="#3">Item 3</a></li>
        <li><a href="#4">Item 4</a></li>
        <li><a href="#5">Item 5</a></li>
        <li><a href="#6">Item 6</a></li>
    </ul>
    <button class="toggle">TOGGLE</button>
    <ul class="dropdown">
        <li><a href="#1">Responsive Item 1</a></li>
        <li><a href="#2">Responsive Item 2</a></li>
        <li><a href="#3">Responsive Item 3</a></li>
    </ul>
</nav>
```


## Responsive Considerations

In the case of a "fixed"-style navigation (with the "top" or "bottom" CSS 
classes), the bar will extend the full width of the page. Otherwise, the bar 
will stretch to fit the width of its container.

The bar turns into a vertical list in smaller viewports, with a toggle button
appearing to cause this list to drop down. If a `.toggle` button is explicitly
defined, it will appear when this occurs. If one is not explicitly defined, then
the framework generates one.