# Gallery

## Definition

A Gallery is a collection of images grouped by a common conceptual/content purpose (i.e. to 
demonstrate a project portfolio, to showcase photographs documenting an event, to display available products in a product line). The gallery can be an interactive (javascript) component or not. 

## Usages

* Use only for a group of images that are related by purpose; Users assumptions will be that these images are related.
* If interactive gallery, player controls should be supported.
* If position is not critical use figure/fig caption to mark up the gallery; if it is use div.
* If using figure, the optional caption should be marked up as a fig caption; html5 stipulates that only one fig caption may be nested in a figure while multiple images can be.


## Responsive Considerations

Image resizing will be an issue. 
For static gallery sets (displaying a collection of thumbnails) the re-configuration of
rows and columns will also be an issue.