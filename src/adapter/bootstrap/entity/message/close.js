typeof jQuery != 'undefined' && (function ($, window, document, undefined) {

    $(window).load(function(){

        if(typeof $.fn.alert != 'function')
            return;

        $('.message.closeable').each(function(){
            if($(this).find('.close').length > 0)
                return;

            $(this).prepend('<button type="button" class="close" data-dismiss="alert">×</button>')
        })
    });

})(jQuery, window, document);