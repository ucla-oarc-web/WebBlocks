/**
 * Fluid Images - IE < 8 AlphaImageLoader-based Scaling
 * http://unstoppablerobotninja.com/entry/fluid-images
 * 
 * Copyright (c) 2009, Ethan Marcotte
 * All rights reserved.
 */

var imgSizer = {
     Config : {
          imgCache : []
          ,spacer : "/path/to/your/spacer.gif"
     }
     ,collate : function(aScope) {
          var isOldIE = (document.all && !window.opera && !window.XDomainRequest) ? 1 : 0;
          if (isOldIE && document.getElementsByTagName) {
               var c = imgSizer;
               var imgCache = c.Config.imgCache;
               var images = (aScope && aScope.length) ? aScope : document.getElementsByTagName("img");
               for (var i = 0; i < images.length; i++) {
                    images.origWidth = images.offsetWidth;
                    images.origHeight = images.offsetHeight;
                    imgCache.push(images);
                    c.ieAlpha(images);
                    images.style.width = "100%";
               }
               if (imgCache.length) {
                    c.resize(function() {
                         for (var i = 0; i < imgCache.length; i++) {
                              var ratio = (imgCache.offsetWidth / imgCache.origWidth);
                              imgCache.style.height = (imgCache.origHeight * ratio) + "px";
                         }
                    });
               }
          }
     }
     ,ieAlpha : function(img) {
          var c = imgSizer;
          if (img.oldSrc) {
               img.src = img.oldSrc;
          }
          var src = img.src;
          img.style.width = img.offsetWidth + "px";
          img.style.height = img.offsetHeight + "px";
          img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "', sizingMethod='scale')"
          img.oldSrc = src;
          img.src = c.Config.spacer;
     }
     // Ghettomodified version of Simon Willison's addLoadEvent() -- http://simonwillison.net/2004/May/26/addLoadEvent/
     ,resize : function(func) {
          var oldonresize = window.onresize;
          if (typeof window.onresize != 'function') {
               window.onresize = func;
          } else {
               window.onresize = function() {
                    if (oldonresize) {
                         oldonresize();
                    }
                    func();
               }
          }
     }
}