# Gallery

## Definition

A Gallery is a collection of images grouped by a common conceptual/content purpose. 

## Usages

* Use only for a group of images that are related by purpose; Users assumptions will be that these images are related.
* Common usages: demonstrate a project portfolio, showcase photographs documenting an event, display available products in a product line.

## Features
* The gallery can be an interactive (javascript) component or not.
* Interactive media features are optionally supported (js slideshow/ js carousel/ js accordion / video player); in such a case player controls will need to be rendered.
* If position is not critical use figure/fig caption to mark up the gallery; if it is use div.
* If using figure, the optional caption should be marked up as a fig caption; html5 stipulates that only one fig caption may be nested in a figure while multiple images can be. 
* If each image requires its own caption, use the nested figure alternative markup.


## Responsive Considerations

* Image resizing will be an issue. 
* For static gallery sets (displaying a collection of thumbnails) the re-configuration of
rows and columns will also be an issue.