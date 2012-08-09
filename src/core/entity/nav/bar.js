(function(){
    $(window).resize(function(){
        $('nav.bar').each(function(){

            var overflow = false;

            if($(this).css('position') == 'static')
                $(this).css('position', 'relative');

            $(this).find('> ul li').each(function(){
                if($(this).position().top > 1)
                    overflow = true;
            });

            if(overflow){
                console.log("Overflow detected (STUB!)");
            }
        });
    });
})();
