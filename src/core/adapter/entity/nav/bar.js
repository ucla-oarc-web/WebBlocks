//!requires_package jquery

typeof jQuery != 'undefined' && (function ($, window, document, undefined) {

    $(document).addBlocksMethod('navbar',function(command){

        var commands = {

            'init': function(){

                var $this = $(this)
                $.each(['top','bottom'], function(){
                    var type = this.toString();
                    if($this.filter(function(){$(this).hasClass(type)}).length > 1)
                        $('body').css('padding-'+type,$(this).outerHeight(true)+10);
                });

                $this.each(function(){
                    var $ul = $(this).find('ul:not(.dropdown)')
                    if($(this).children('.toggle').length == 0){
                        $ul.after('<a target="#" class="toggle auto">'+($(this).hasClass('bottom') ? '&#x25B2;' : '&#x25BC;')+'</a>')
                    }
                    if($ul.length > 0 && $(this).children('ul.dropdown').length == 0){
                        $ul.clone().attr('class','dropdown').appendTo(this);
                    }
                    $(this).find('.toggle').click(function(){

                        var $closest = $(this).closest('nav.bar.overflow'),
                            active = $closest.hasClass('active'),
                            bottom = $closest.hasClass('bottom');

                        if(active)
                            $closest.removeClass('active')
                        else
                            $closest.addClass('active')

                        if($(this).hasClass('auto')){
                            if(bottom ? !active : active)
                                $(this).html('&#x25BC;')
                            else
                                $(this).html('&#x25B2;')
                        }
                    })
                })

                commands['reflow'].apply(this)

            },

            'reflow': function(){

                $(this).removeClass('overflow');

                $(this).each(function(){
                    var $children = $(this).find('> * , ul:not(.dropdown) > li'),
                        pos = $children.first().offset().top,
                        overflow = false
                    $children.each(function(){
                        if($(this).is(':visible') && $(this).offset().top != pos)
                            overflow = true
                    })

                    if(overflow){
                        $(this).addClass('overflow')
                    }
                })

            }

        }

        commands[command] && commands[command].call($(this), Array.prototype.slice.call(arguments,1));

    });

    $(window).load(function(){

        $('nav.bar').blocks().navbar('init');

        $(window).resize(function(){
            $('nav.bar').blocks().navbar('reflow');
        });

    });

})(jQuery, window, document);
