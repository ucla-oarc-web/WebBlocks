(function(){
    
    var reflowFixedNavbars = function(){
        var l = ['top','bottom']
        for(var i in l){
            var $navbar = $('nav.bar.'+l[i])
            if($navbar.length > 0)
                $('body').css('padding-'+l[i],$navbar.outerHeight(true))
        }
    }
    
    var addNavbarOverflowDropdown = function(){
        $('nav.bar').each(function(){
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
    }
    
    var reflowNavbarOverflows = function(){
        $('nav.bar.overflow').each(function(){
            $(this).removeClass('overflow')
        })
        $('nav.bar').each(function(){
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
    
    $(window).load(reflowFixedNavbars)
    $(window).load(addNavbarOverflowDropdown)
    $(window).load(reflowNavbarOverflows);
    $(window).resize(reflowNavbarOverflows)
    
})()


