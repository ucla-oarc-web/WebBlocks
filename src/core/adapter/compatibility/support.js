//!requires_package modernizr

window.addEventListener("load", function(){ 
    if(typeof Modernizr == 'undefined'){
        window.console && console.warn('Could not load Compatibility/Supports tests into Modernizr because Modernizr is not available')
        Blocks.support = {
            'required': function(){ return false },
            'full': function(){ return false }
        }
    }
}, true);

Blocks.support = {};

(function(M, B){
    B.required = function(){
        return M.blocks_css_required
            && M.blocks_html_required
    }
    B.full = function(){
        return M.blocks_css_full 
            && M.blocks_html_full
    }
})(Modernizr, Blocks.support);
