// current script is the last script, as this occurs at runtime
var scripts = document.getElementsByTagName('script');

// get directory's parent directory to figure out where images reside
var dir = (scripts[scripts.length-1].src.split('?')[0]).split('/').slice(0, -2).join('/')+'/';

// set configuration for imgSizer
// package loader should replace [IMGDIR] with the image directory
imgSizer.Config.spacer = dir + '[IMGDIR]/alphaimagescaling/spacer.gif';

// invoke imgSizer via Simon Willison's addLoadEvent
// http://blog.simonwillison.net/post/57956760515/addloadevent
(function(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      if (oldonload) {
        oldonload();
      }
      func();
    }
  }
})(imgSizer.collate)