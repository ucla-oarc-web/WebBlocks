# Blockquote

## Definition

A blockquote represents quoted content that is semantically offset from the rest of the content on a page. The content
is generally offset due to length or significance.

## Usages

* Quote an outside source (for example, an excerpt from a blog article or a passage from a book)
* Redundantly quote a noteworthy portion of a current body of text to call attention to the quoted content

## Features

The `blockquote` element can either be used on its own for a simple quote without attribution or nested within a
`figure` element with a corresponding `figcaption` to create a quote with attribution. Attribution for a blockquote
can not be placed within a `blockquote` element (http://www.whatwg.org/specs/web-apps/current-work/#the-blockquote-element).

If the quoted material is located at an accessible URL, provide the URL within the `cite` attribute of the `blockquote`
element.

By default, a blockquote will stretch to fit the full width of its container. However, the optional `callout` CSS
class can be added to create a smaller, more compact style that will allow wrapped text for quotes that are intended
to be "callout" quotes dropped throughout a body of text (see the second usage above).

The `text-right` CSS class can be applied to the containing `figure` or `blockquote` element to the align the contents of the
blockquote to the right.

## Responsive Considerations

* The standard blockquote will stretch to fit the full width of its container, so adapting to fit a responsive design
is not a major concern. Some stylistic padding and margin may be removed to create a more condensed look and feel for
the smallest viewports
* The `callout` version of the blockquote should change to fit the full width of its container for smaller viewports