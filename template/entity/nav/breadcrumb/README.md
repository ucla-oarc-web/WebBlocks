# Nav/Breadcrumb

## Definition

Breadcrumb navigation is used to display the User's current location within a website. For example, if a User is
visiting the "Types" section of the "Apples" section within the "Fruit" section of a website, they might see the 
following breadcrumb navigation:

``
Fruit > Apples > Types
``

In this example, "Fruit" and "Apples" would be links to those respective sections of the website. Breadcrumb navigation
should not be used as the primary navigation of a website.

## Usages

* Display the ancestor sections leading to the User's current section on the website

## Features

### Ordered vs Unordered

An `ol` element is considered more semantic over a `ul` for breadcrumb navigation due to the fact that there is an
ordering to the items within the breadcrumb (a hierarchical ordering).

### Links vs Plain Text

Although using links is recommended for optimum usability, the breadcrumb trail does not necessarily need to contain
links. Plain text can be used instead.

### "Active" Breadcrumb Item

To denote the "active" or "current" item in the breadcrumb trail, add the "active" CSS class to the `li` element
containing the breadcrumb item.

### Dividers

A breadcrumb can be styled using CSS, of course, but you can also use a simpler text-based divider glyph between
each of the items within your breadcrumb trail by adding a `span` element with CSS class "divider" containing the
divider glyph (a "/" or ":", for example).

## Responsive Considerations

The breadcrumb should fit the full width of its container, shrinking with the container in smaller viewport width.