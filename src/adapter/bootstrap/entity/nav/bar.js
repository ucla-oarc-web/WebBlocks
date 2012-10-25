$(window).load(function(){
    var l = ['top','bottom']
    for(var i in l){
        var $navbar = $('nav.bar.'+l[i])
        if($navbar.length > 0)
            $('body').css('padding-'+l[i],$navbar.outerHeight(true))
    }
})
