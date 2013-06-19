typeof Modernizr != 'undefined' && (function(M){
    
    M.addTest({
        'blocks_css_required': function(){
            return M.mq('only all and (min-width: 0px)')
                && M.mq('(max-width: 9999px)')
        },
        'blocks_css_full': function(){
            return M.blocks_css_required
                && M.borderradius 
                && M.cssgradients
                && M.fontface // not actually used by anything yet
                && M.textshadow 
        }
    })
    
})(Modernizr);
