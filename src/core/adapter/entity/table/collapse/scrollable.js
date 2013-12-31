//!requires_package jquery

typeof jQuery != 'undefined' && (function ($, window, document, undefined) {
    $(window).load(function(){
        $('.table.scrollable-collapse').blocks().overflowScrollable('init');
    });
})(jQuery, window, document);