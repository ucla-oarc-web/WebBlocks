var DOC = {
    
    'menu':['api','configuration','recipe','core'],
    
    'vars':{sass:{},rake:{}},
    
    'modules':{},
    
    'go':function(name, fade){

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

            $('#content').fadeIn(fadeTime, function(){
                if($(document).blocks().ariaMapper)
                    $('body').blocks().ariaMapper()
                if($(document).blocks().navbar)
                    $('#content nav.bar').blocks().navbar('init');
                if($(document).blocks().overflowScrollable)
                    $('#content .table.scrollable-collapse').blocks().overflowScrollable('init')
                if($(document).blocks().requiredFormControls)
                    $('#content form.form').blocks().requiredFormControls('init');
            })

        })
        
    }
}