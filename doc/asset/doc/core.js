var DOC = {
    
    'menu':['api','configuration','recipe','core'],
    
    'vars':{sass:{},rake:{}},
    
    'modules':{},
    
    'loading': false,
    
    'prefetched': [],
    
    'prefetch':function(name){

        if(DOC.prefetched.indexOf(name) >= 0)
            return 0
        
        try{
            (new EJS({url: 'page/'+name+'.ejs'})).render(DOC);
            DOC.prefetched.push(name)
            return 1
        }catch(e){
            return -1
        }
        
    },
    
    'go':function(name, fade){

        DOC.loading = true

        var page,
            fadeTime = typeof fade == 'undefined' ? 400 : parseInt(fade);
        name = name.toLowerCase()

        $('#content').fadeOut(fadeTime, function(){

            $('#content').html('')
            if($('#menu.active').length > 0)
            $('#menu .toggle').click()
            $('body').scrollTop(0)
            try{
                page = new EJS({url: 'page/'+name+'.ejs'})
            }catch(e){
                page = new EJS({url: 'page/construction.ejs'})
            }
            if($.inArray(name.split('/')[0], DOC.menu) < 0){
                $('#content').append('<div class="panel-12">'+page.render(DOC)+'</div>')
            }else{
                var menu = new EJS({url: 'component/menu/'+name.split('/')[0]+'.ejs'}),
                    menuContents = menu.render(DOC),
                    menuSet = '<div class="hide-small">'
                                +menuContents
                                +'</div>'
                                +'<div class="hide-above-small" style="margin-bottom:10px;">'
                                    +'<div data-effect="toggle" data-toggle="show slide" data-target=".menu-show"'
                                        +' class="menu-show text-center"'
                                        +' style="padding:8px;background-color:#f2f2f2;color:#1042bc;cursor:pointer;border-radius:8px">'
                                        +'Show Articles'
                                    +'</div>'
                                    +'<div data-effect="toggle" data-toggle="slide" class="menu-show">'
                                        +menuContents
                                    +'</div>'
                                +'</div>'
                            
                
                $('#content').append('<div class="panel-3">'+menuSet+'</div>')
                $('#content').append('<div class="panel-9">'+page.render(DOC)+'</div>')
            }
            
            $('#content').efx()
            prettyPrint()

            $('#content').fadeIn(fadeTime)
            
            DOC.loading = false
            
            var currentUrl = window.location.href,
                hashPos = currentUrl.indexOf('#'),
                loading = false,
                prefetchUrl, prefetchAnchor, status
            if(hashPos >= 0)
                currentUrl = currentUrl.substring(0,hashPos)
            
            $('body a').each(function(){
                
                if(DOC.loading)
                    loading = true // prepare to aboart because new DOC.go() request has been made
                
                if(loading)
                    return false; // abort because a new loading request occurred
                
                prefetchUrl = $(this).attr('href')
                
                if(typeof prefetchUrl != 'string')
                    return; // abort because no href
                
                if(prefetchUrl.substring(0,hashPos) == currentUrl){
                    prefetchAnchor = prefetchUrl.substring(hashPos)
                }else if(prefetchUrl.substring(0,1) == '#'){
                    prefetchAnchor = prefetchUrl.substring(1)
                }else{
                    return; // abort because not an anchor prefetch
                }
                
                status = DOC.prefetch(prefetchAnchor)
                
                if(window.console)
                    switch(status){
                        case 1: console.log('Prefetch PASS: '+prefetchAnchor); break;
                        case 0: console.log('Prefetch SKIP: '+prefetchAnchor); break;
                        default: console.log('Prefetch FAIL: '+prefetchAnchor); break;
                    }
                
            })

        })
        
    }
}