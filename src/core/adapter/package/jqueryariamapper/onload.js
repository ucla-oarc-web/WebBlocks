//!require_package jquery
//!require_package jqueryariamapper

typeof jQuery != 'undefined' && (function ($, window, document, undefined) {
    $(window).load(function(){
        $('body').blocks().ariaMapper()
    })
})(jQuery, window, document);