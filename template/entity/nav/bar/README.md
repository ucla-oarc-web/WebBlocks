# Nav/Bar

## Definition

The "bar"-style navigation is a horizontal navigation menu, often located at the topmost part of
the page.

## Usages

* Contain the main, top-level navigation of the website
* Contain an alternative, ancillary form of navigation (e.g., links to role-based sections, like

## Features

### Fixed Positioning

The "top" or "bottom" CSS classes can be added to the containing `nav` element to create a menu
that is fixed either to the bottom or top of the User's screen. Thus, when the User scrolls, the
menu will stay in that position.

### "Active" Navigation Item

To denote the "active" or "current" item in the navigation, add the "active" CSS class to the
`li` element of the active navigation item.

## Responsive Considerations

In the case of a "fixed"-style navigation (with the "top" or "bottom" CSS classes), the bar will
extend the full width of the page in larger, desktop-sized viewports. Otherwise, the bar will
stretch to fit the width of its container.

In either case, however, the bar will turn into a vertical list in smaller viewports. If the
"togglable" CSS class has been applied, the list can be expanded and collapsed to conserve
space using the "toggle" `a` or `button` element. The "toggle" `a` or `button` element
would not appear on viewports where it is not applicable.

When fixed, the navigation will revert to a static position at the top of the page on smaller
viewports, rather than remaining fixed while the User scrolls.

A header element can be added to the `nav` to display the title of the navigation, which can be
especially useful when the menu is collapsed.