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
        },
        'table-caption-text-color': {
            description:'defines the color of table caption text',
            default_value:'#777',
            type:'color'
        },
        'table-border-color': {
            description:'defines the color of the table border',
            default_value:'#ddd',
            type:'color'
        },
        'table-cell-padding': {
            description:'defines cell padding for table',
            default_value:'8px',
            type:'px (set)'
        },
        'table-condensed-cell-padding': {
            description:'defines cell padding for condensed table',
            default_value:'4px 5px',
            type:'px (set)'
        },
        'table-hover-background-color': {
            description:'defines background color for table on hover',
            default_value:'#f5f5f5',
            type:'color'
        },
        'table-striped-background-color': {
            description:'defines background color for stripped table row',
            default_value:'#f9f9f9',
            type:'color'
        },
        'table-bordered-border-radius': {
            description:'defines radius of a bordered table',
            default_value:'4px',
            type:'px'
        },
        'color-branding-default': {
            description:'defines base for default color',
            default_value:'#eee',
            type:'color'
        },
        'color-branding-primary': {
            description:'defines base for primary color',
            default_value:'#0a2a77',
            type:'color'
        },
        'color-branding-secondary': {
            description:'defines base for secondary color',
            default_value:'#7bc0de',
            type:'color'
        },
        'color-branding-tertiary': {
            description:'defines base for tertiary color',
            default_value:'#ffd44d',
            type:'color'
        },
        'color-branding-neutral': {
            description:'defines base for neutral color',
            default_value:'#bbb',
            type:'color'
        },
        'color-mood-info': {
            description:'defines base for info color',
            default_value:'#2f96b4',
            type:'color'
        },
        'color-mood-success': {
            description:'defines base for success color',
            default_value:'#51a351',
            type:'color'
        },
        'color-mood-warning': {
            description:'defines base for warning color',
            default_value:'#c86d04',
            type:'color'
        },
        'color-mood-error': {
            description:'defines base for error color',
            default_value:'#bd362f',
            type:'color'
        },
        'color-mood-danger': {
            description:'defines base for danger color',
            default_value:'#bd362f',
            type:'color'
        },
        'color-mood-inverse': {
            description:'defines base for inverse color',
            default_value:'#222',
            type:'color'
        },
        'color-mood-important': {
            description:'defines base for important color',
            default_value:'#bd362f',
            type:'color'
        },
        'color-mood-required': {
            description:'defines base for required color',
            default_value:'#a00',
            type:'color'
        },
        'color-mood-highlight': {
            description:'defines base for highlight color',
            default_value:'#97E0E0',
            type:'color'
        },
        'color-grade-lt': {
            description:'percentage color is lightened for gradient',
            default_value:'10%',
            type:'percent'
        },
        'color-grade-dk': {
            description:'percentage color is darkened for border',
            default_value:'10%',
            type:'percent'
        },
        'color-grade-dk-text': {
            description:'percentage text is darkened when background below <code>$color-light-border-brightness</code> brightness',
            default_value:'80%',
            type:'percent'
        },
        'color-grade-lt-text': {
            description:'percentage text is lightened when background above <code>$color-light-border-brightness</code> brightness',
            default_value:'93%',
            type:'percent'
        },
        'color-text-brightness': {
            description:'brightness percentage for <code>text-</code> classes',
            default_value:'40%',
            type:'percent'
        },
        'color-background-light-brightness': {
            description:'brightness percentage for <code>.light</code> background color',
            default_value:'95%',
            type:'percent'
        },
        'color-background-shadow-light-brightness': {
            description:'brightness percentage for <code>.gradient</code> shadow color',
            default_value:'85%',
            type:'percent'
        },
        'color-light-border-brightness': {
            description:'brightness percentage for light border',
            default_value:'60%',
            type:'percent'
        },
        'color-contrast-threshold': {
            description:'generic threshold used to select light instead of dark color',
            default_value:'65%',
            type:'percent'
        }
    }

    DOC.vars.sass.render = function(name){
        var variableView = new EJS({url: 'component/variable.ejs'}), 
            data = sass_vars[name]
        data.name = name
        return variableView.render(data)
    }
    
})();