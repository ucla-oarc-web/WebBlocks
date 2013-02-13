(function(){
    
    var sass_vars = {
        'structure-container-gutter': {
            description:'defines padding around the container',
            default_value:'2%',
            type:'percentage'
        },
        'structure-container-width-max': {
            description:'defines the maximum size of the container',
            default_value:'1024px',
            type:'pixels, false'
        },
        'breakpoint-xxsmall': {
            description:'defines breakpoint used by <code>.hide-xxsmall, .hide-above-xxsmall, .row.xxsmall-collapse</code>',
            default_value:'360px',
            type:'px'
        },
        'breakpoint-xsmall': {
            description:'defines breakpoint used by <code>.hide-xsmall, .hide-above-xsmall, .row.xsmall-collapse</code>',
            default_value:'480px',
            type:'px'
        },
        'breakpoint-small': {
            description:'defines breakpoint used by <code>.hide-small, .hide-above-small, .row.small-collapse</code>',
            default_value:'600px',
            type:'px'
        },
        'breakpoint-medium-small': {
            description:'defines breakpoint used by <code>.hide-medium-small, .hide-above-medium-small, .row.medium-small-collapse</code>',
            default_value:'768px',
            type:'px'
        },
        'breakpoint-medium': {
            description:'defines breakpoint used by <code>.hide-medium, .hide-above-medium, .row.medium-collapse</code>',
            default_value:'960px',
            type:'px'
        },
        'breakpoint-medium-large': {
            description:'defines breakpoint used by <code>.hide-medium-large, .hide-above-medium-large, .row.medium-large-collapse</code>',
            default_value:'1024px',
            type:'px'
        },
        'breakpoint-large': {
            description:'defines breakpoint used by <code>.hide-large, .hide-above-large, .row.large-collapse</code>',
            default_value:'1200px',
            type:'px'
        },
        'structure-panels': {
            description:'defines number of panels in a row',
            default_value:'12',
            type:'integer'
        },
        'structure-panel-gutter': {
            description:'defines spacing between panels',
            default_value:'2.5641%',
            type:'percentage'
        },
        'type-font-family': {
            description:'defines the body font family',
            default_value:'"Helvetica Neue", Helvetica, Arial, sans-serif;',
            type:'font-family (list)'
        },
        'type-font-size': {
            description:'defines the body font size',
            default_value:'0.93em',
            type:'em (recommended), px'
        },
        'type-font-size-small': {
            description:'defines <code>small</code> font size',
            default_value:'0.93em',
            type:'em (recommended), px'
        },
        'type-font-size-h1': {
            description:'defines <code>h1</code> font size',
            default_value:'2.5em',
            type:'em (recommended), px'
        },
        'type-font-size-h2': {
            description:'defines <code>h2</code> font size',
            default_value:'2.2em',
            type:'em (recommended), px'
        },
        'type-font-size-h3': {
            description:'defines <code>h3</code> font size',
            default_value:'1.75em',
            type:'em (recommended), px'
        },
        'type-font-size-h4': {
            description:'defines <code>h4</code> font size',
            default_value:'1.5em',
            type:'em (recommended), px'
        },
        'type-font-size-h5': {
            description:'defines <code>h5</code> font size',
            default_value:'1.25em',
            type:'em (recommended), px'
        },
        'type-font-size-h6': {
            description:'defines <code>h6</code> font size',
            default_value:'1.1em',
            type:'em (recommended), px'
        },
        'type-font-size-h1-small': {
            description:'defines <code>h1 small</code> font size',
            default_value:'0.6em',
            type:'em (recommended), px'
        },
        'type-font-size-h2-small': {
            description:'defines <code>h2 small</code> font size',
            default_value:'0.65em',
            type:'em (recommended), px'
        },
        'type-font-size-h3-small': {
            description:'defines <code>h3 small</code> font size',
            default_value:'0.7em',
            type:'em (recommended), px'
        },
        'type-font-size-h4-small': {
            description:'defines <code>h4 small</code> font size',
            default_value:'0.8em',
            type:'em (recommended), px'
        },
        'type-font-size-h5-small': {
            description:'defines <code>h5 small</code> font size',
            default_value:'0.9em',
            type:'em (recommended), px'
        },
        'type-font-size-h6-small': {
            description:'defines <code>h6 small</code> font size',
            default_value:'0.9em',
            type:'em (recommended), px'
        },
        'type-line-spacing': {
            description:'defines the spacing between lines',
            default_value:'20px',
            type:'px (recommended), em',
            note:'prefers <code>px</code> to <code>em</code> for uniform spacing'
        },
        'type-line-height': {
            description:'defines <code>p, li, address, blockquote</code> line height',
            default_value:'1',
            type:'em (recommended), px'
        },
        'type-line-height-heading': {
            description:'defines header line heights',
            default_value:'1.4',
            type:'em (recommended), px'
        }
    }

    DOC.vars.sass.render = function(name){
        var variableView = new EJS({url: 'component/variable.ejs'}), 
            data = sass_vars[name]
        data.name = name
        return variableView.render(data)
    }
    
})();