# Table

## Definition

A `table.table` is used to represent tabular data.

## Usages

* Present tabular data
* Structure a form for updating and editing tabular data

## Features

### Customizing the Table

The `.striped` CSS class can be added to the root `table.table` element to add zebra striping to the table.

The `.bordered` CSS class can be added to the root `table.table` element to add rounded borders around the table. Each
individual row within the table will already have borders between each row, even without the `.bordered` class.

The `.condensed` CSS class can be added to the root `table.table` element to reduce the margin and padding from cells.

### Highlighting

Upon hover, each row within the table will be softly highlighted so that the User can easily spot the cells within the
row they are currently viewing. The color used for this hover highlight should be a unique color, different from the
colors used in zebra striping, static row or column higlighting (below), and header rows/cells.

Also, static highlighting can be added to a row so that a specific row will always be highlighted by adding the
`.highlight` CSS class to the targeted `tr` element. This should also be a unique color (also different than the color
used in hover highlighting).

The `.highlight` CSS class can also be added to a `col` element to higlight an entire column (using the same highlight
color as the static row highlighting).

## Responsive Considerations

TODO