# Entity/Message

## Definition

A message is a user interface element that stands out of the interface with 
information pertinent to the user.

## Usages

A message has many use including:

* Notifications
* Success messages
* Error alerts

## Features

A message is generally defined on a `div` element. However, it may be defined
on any block-level element based on semantic purpose. To style the message,
add the CSS class `button`, as well as any additional branding or mood
styles such as:

```html
<div class="message primary">Message with primary branding</div>
<div class="message secondary">Message with secondary branding</div>
<div class="message danger">Message with danger mood like an error</div>
<div class="message success">Message with success mood</div>
<div class="message required">Message specifying required action</div>
```

### Close Message

Some adapters (such as Bootstrap) provide the ability to close the message by
pressing a close button. This close button is laid in when the `closeable`
class it attached. While a default button exists, it is also possible to
specify a custom close button by defining an element with a `close` class (and
the `data-dismiss="alert"` attribute in the case of Bootstrap).

```html
<div class="message warning closeable">Closeable message with warning mood</div>
```

## Responsive Considerations

The message is a block-level element that spans the width of its containing
element. As such, responsive considerations do not apply directly to the 
message but rather to the container.
