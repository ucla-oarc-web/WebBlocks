//!requires_package jquery

typeof jQuery != 'undefined' && (function ($, window, document, undefined) {
    $(window).load(function(){
        Blocks.IE.css.filter.borderRadius('nav.bar')
    });
})(jQuery, window, document);