(function(){
    
    var sass_vars = {
        'structure-container-gutter': {
            description:'defines padding around the container',
            default_value:'2%',
            type:'percent'
        },
        'structure-container-width-max': {
            description:'defines the maximum size of the container',
            default_value:'1024px',
            type:'px, false'
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
            default_value:'640px',
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
            description:'brightness percentage for <code>.light.gradient</code> shadow color',
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
        },
        'form-horizontal-offset': {
            description:'width of labels column in <code>form.form.horizontal</code>',
            default_value:'180px',
            type:'px, percent'
        },
        'form-legend-border-color': {
            description:'color of the line displayed below a <code>legend</code> within <code>form.form fieldset</code>',
            default_value:'#eee',
            type:'color'
        },
        'form-legend-color': {
            description:'color of the text of a <code>legend</code> within <code>form.form fieldset</code>',
            default_value:'#111',
            type:'color'
        },
        'form-legend-small-color': {
            description:'color of the text of a <code>legend small</code> within <code>form.form fieldset</code>',
            default_value:'#666',
            type:'color'
        },
        'form-input-size-mini': {
            description:'size of an <code>input.mini</code> within <code>form.form</code>',
            default_value:'60px',
            type:'px, percent'
        },
        'form-input-size-small': {
            description:'size of an <code>input.small</code> within <code>form.form</code>',
            default_value:'90px',
            type:'px, percent'
        },
        'form-input-size': {
            description:'size of an <code>input</code> within <code>form.form</code>',
            default_value:'210px',
            type:'px, percent'
        },
        'form-input-size-large': {
            description:'size of an <code>input.large</code> within <code>form.form</code>',
            default_value:'240px',
            type:'px, percent'
        },
        'form-input-background-color': {
            description:'background color of <code>input, textarea, select</code> within <code>form.form</code>',
            default_value:'#fff',
            type:'color'
        },
        'form-input-text-color': {
            description:'text color of <code>input, textarea, select</code> within <code>form.form</code>',
            default_value:'#444',
            type:'color'
        },
        'form-input-border-radius': {
            description:'border radius of <code>input, textarea, select</code> within <code>form.form</code>',
            default_value:'4px',
            type:'px'
        },
        'form-input-border-color': {
            description:'border color of <code>input, textarea, select</code> within <code>form.form</code>',
            default_value:'#ddd',
            type:'color'
        },
        'form-input-padding': {
            description:'internal padding for <code>input, textarea, select</code> within <code>form.form</code>',
            default_value:'4px 6px',
            type:'px (set)'
        },
        'form-input-uneditable-text-color': {
            description:'text color for <code>.uneditable-input</code> within <code>form.form</code>',
            default_value:'lighten($form-input-text-color, 20%)',
            type:'color'
        },
        'form-input-uneditable-background-color': {
            description:'background color for <code>.uneditable-input</code> within <code>form.form</code>',
            default_value:'$form-input-background-color',
            type:'color'
        },
        'form-input-uneditable-border-color': {
            description:'border color for <code>.uneditable-input</code> within <code>form.form</code>',
            default_value:'$color-branding-default-border',
            type:'color'
        },
        'form-placeholder-text-color': {
            description:'text color for placeholder text of <code>input, textarea, select</code> within <code>form.form</code>',
            default_value:'lighten($form-input-text-color, 40%)',
            type:'color'
        }
    }
    
    DOC.vars.sass.render_all = function(name){
        var vars = $.extend(true, {}, sass_vars),
            vars_list = [],
            vars_rendered = []
        for(var i in vars)
            vars_list.push(i)
        vars_list.sort()
        for(var i in vars_list)
            vars_rendered.push(DOC.vars.sass.render(vars_list[i]))
        return vars_rendered
    }

    DOC.vars.sass.render = function(name){
        var variableView = new EJS({url: 'component/variable.ejs'}), 
            data = sass_vars[name]
        data.name = name
        return variableView.render(data)
    }
    
})();