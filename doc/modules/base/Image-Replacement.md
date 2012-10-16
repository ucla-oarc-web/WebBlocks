# Base/Image Replacement

## Definition

This library provides utility classes for applying image replacement to an element.

## Usages

* Apply image replacement to an element

## Features

The `.ir` class can be added to an element to apply image replacement to that element.

Image replacement can be used to replace a text element within a document with an image
without placing an image directly in the markup. For example, if a document contained a
link to a Twitter account page using an image of the Twitter logo, it could be implemented
as follows:

```html
<a href="#"><img src="twitter-logo.png" alt="Twitter" /></a>
```

However, the `img` element does not add semantic value to the page in this example;
the image is simply a design implementation. Ideally, we would want to have the
following HTML:

```html
<a href="#">Twitter</a>
```

And then replace the inner text with an image. Image replacement allows for this.

To apply image replacement to an element, add the `.ir` class to the element and
then create a CSS declaration containing the width, height, and background image to
use in image replacement. For example:

```html
<h1>Website Title</h1>
```

```css
h1
{
	background-image: url(main-logo.png);
	height: 200px;
	width: 500px;
}
```

## Responsive Considerations

None