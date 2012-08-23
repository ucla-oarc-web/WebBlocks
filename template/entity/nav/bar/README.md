# Nav/Bar

## Definition

The "bar"-style navigation is a horizontal navigation menu, often located at the topmost part of
the page.

## Usages

* Contain the main, top-level navigation of the website
* Contain an alternative, ancillary form of navigation (e.g., links to role-based sections, like
"Students" or "Parents")
* Contain the search form
* Contain a minor utility section of the website (e.g., current weather)

## Features

### Fixed Positioning

The "top" or "bottom" CSS classes can be added to the containing `nav` element to create a menu
that is fixed either to the bottom or top of the User's screen. Thus, when the User scrolls, the
menu will stay in that position.

### Including Other Content

Besides navigation, a `header` or `article` can be added to the `nav` element. This element can
contain either the title of the website (in the case of `header`) or a minor utility section
(in the case of `aside`) that would be useful placed near the bar's navigation (e.g., a search
form or the current weather).

### "Active" Navigation Item

To denote the "active" or "current" item in the navigation, add the "active" CSS class to the
`li` element of the active navigation item.

## Responsive Considerations

In the case of a "fixed"-style navigation (with the "top" or "bottom" CSS classes), the bar will
extend the full width of the page in larger, desktop-sized viewports. Otherwise, the bar will
stretch to fit the width of its container.

In either case, however, the bar will turn into a vertical list in smaller viewports. If the
"toggle" `a` or `button` element is present, the list can be expanded and collapsed to conserve
space. On smaller viewports, the navigation will revert to a static position at the top of the
page, rather than remaining fixed while the User scrolls. The "toggle" `a` or `button` element
would not appear on viewports where it is not applicable.