typeof Modernizr != 'undefined' && (function(M){
    
    M.addTest({
        'blocks_html_required': function(){
            return true // stub as no HTML/DOM components currently required
        },
        'blocks_html_full': function(){
            return M.blocks_html_required
                && M.inlinesvg
                && M.svg
        }
    })
    
})(Modernizr);
