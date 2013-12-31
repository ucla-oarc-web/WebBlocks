if(typeof Blocks == 'undefined')
    var Blocks = {};

typeof jQuery != 'undefined' && (function ($, window, document, undefined) {

    var methods = {};

    $.fn.addBlocksMethod = function(name, method){
        methods[name] = method;
    }

    $.fn.blocks = function() {
        var that = $(this)
        $.each(methods, function(name, method){
            that[name] = method;
        })
        return that;
    }
})(jQuery, window, document);