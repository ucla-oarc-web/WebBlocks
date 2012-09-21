# Button

## Definition

A button is a user interface element that a User can "press" to cause some action within the application.

## Usages

A button has many uses, including:

* Submit a form
* Toggle state
* Close a dialog

## Features

A button can be created using three different HTML elements:

1. `a`
2. `button`
3. `input` (with `type` equal to "submit", "button", or "reset")

To style the element as a button, simply add the CSS class "button." The semantic color classes (e.g., "success",
"warning", and "inverse") can also be added to style the button appopriately.

### Disabled State

You can indicate that a button is disabled by either adding the "disabled" CSS class or adding the
"disabled" attribute to the element. Although both methods will work, adding the attribute should be preferred unless
it is not possible (as in the case of the `a` element).

### Button Size

Button size can be controlled via using one of the CSS utility classes ("large", "small", and "mini").

## Responsive Considerations

The button should not require any responsive adaptation since it is more or less an inline element.