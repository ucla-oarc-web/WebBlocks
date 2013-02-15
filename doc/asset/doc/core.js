var DOC = {
    
    'menu':['api','configuration','recipe','development'],
    
    'vars':{sass:{},rake:{}},
    
    'modules':{},
    
    'go':function(name, fade){

        var page,
            fadeTime = typeof fade == 'undefined' ? 400 : parseInt(fade);
        name = name.toLowerCase()

        $('#content').fadeOut(fadeTime, function(){

            $('#content').html('')
            try{
                page = new EJS({url: 'page/'+name+'.ejs'})
            }catch(e){
                page = new EJS({url: 'page/construction.ejs'})
            }
            if($.inArray(name.split('/')[0], DOC.menu) < 0){
                $('#content').append('<div class="panel-12">'+page.render(DOC)+'</div>')
            }else{
                var menu = new EJS({url: 'component/menu/'+name.split('/')[0]+'.ejs'})
                $('#content').append('<div class="panel-3">'+menu.render(DOC)+'</div>')
                $('#content').append('<div class="panel-9">'+page.render(DOC)+'</div>')
            }
            
            $('#content').efx()
            prettyPrint()

            $('#content').fadeIn(fadeTime)

        })
    }
}