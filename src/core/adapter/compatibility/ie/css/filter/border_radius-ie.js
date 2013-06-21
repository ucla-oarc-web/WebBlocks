//!requires_package jquery

Blocks.IE.css.filter.borderRadius = function(ele){
    $(ele).each(function(){

        var y=['top','bottom'],
            x=['left','right'],
            i, j,
            props = [];

        for(i in x)
            for(j in y){
                var prop = 'border-'+y[j]+'-'+x[i]+'-radius',
                    value = $(this).css(prop)
                if(value != '0px')
                    props.push(prop+':'+value)
            }

        if(props.length > 0){
            if($(this).css('position') == 'fixed'){
                
                $(this).css('position', false)
                
                props.push('position:fixed')
                
                for(i in x){
                    var v = $(this).css(x[i])
                    if(v != 'auto')
                        props.push(x[i]+':'+v)
                }
                
                for(i in y){
                    var v = $(this).css(y[i])
                    if(v != 'auto')
                        props.push(y[i]+':'+v)
                }
                        
            }
            
            $(this).wrap('<div style="'+props.join(';')+';overflow:hidden"></div>')
        }
    })
}