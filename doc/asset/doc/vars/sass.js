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
        'structure-cluster-element-gutter': {
            description:'defines spacing between cluster elements',
            default_value:'2.5641%',
            type:'percentage'
        },
        'structure-cluster-breakpoint-2-columns': {
            description:'defines breakpoint at which cluster elements may be presented in up to two columns',
            default_value:'480px',
            type:'px'
        },
        'structure-cluster-breakpoint-3-columns': {
            description:'defines breakpoint at which cluster elements may be presented in up to three columns',
            default_value:'640px',
            type:'px'
        },
        'structure-cluster-breakpoint-4-columns': {
            description:'defines breakpoint at which elements may be presented in up to four columns',
            default_value:'768px',
            type:'px'
        },
        'structure-cluster-breakpoint-6-columns': {
            description:'defines breakpoint at which elements may be presented in up to six columns',
            default_value:'960px',
            type:'px'
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
            default_value:'2.6em',
            type:'em (recommended), px'
        },
        'type-font-size-h2': {
            description:'defines <code>h2</code> font size',
            default_value:'2.25em',
            type:'em (recommended), px'
        },
        'type-font-size-h3': {
            description:'defines <code>h3</code> font size',
            default_value:'1.7em',
            type:'em (recommended), px'
        },
        'type-font-size-h4': {
            description:'defines <code>h4</code> font size',
            default_value:'1.4em',
            type:'em (recommended), px'
        },
        'type-font-size-h5': {
            description:'defines <code>h5</code> font size',
            default_value:'1.2em',
            type:'em (recommended), px'
        },
        'type-font-size-h6': {
            description:'defines <code>h6</code> font size',
            default_value:'1.05em',
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
            type:'integer'
        },
        'type-line-height-heading': {
            description:'defines header line heights',
            default_value:'1.4',
            type:'integer'
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
        'button-font-size-mini': {
            description:'defines the font size of .button.mini',
            default_value:'0.73em',
            type:'em (recommended), px'
        },
        'button-font-size-small': {
            description:'defines the font size of .button.small',
            default_value:'0.9em',
            type:'em (recommended), px'
        },
        'button-font-size-default': {
            description:'defines the font size of .button (without size qualifier)',
            default_value:'1.0em',
            type:'em (recommended), px'
        },
        'button-font-size-large': {
            description:'defines the font size of .button.large',
            default_value:'1.1em',
            type:'em (recommended), px'
        },
        'button-padding-multiplier-horizontal': {
            description:'defines a multiplier against 1em for horizontal padding of .button',
            default_value:'1',
            type:'decimal'
        },
        'button-padding-multiplier-vertical': {
            description:'defines a multiplier against 1em for vertical padding of .button',
            default_value:'0.3',
            type:'decimal'
        },
        'button-padding-multiplier-mini-horizontal': {
            description:'defines a multiplier against 1em for horizontal padding of .button.mini, overriding $button-padding-multiplier-horizontal',
            default_value:'1',
            type:'decimal'
        },
        'button-padding-multiplier-mini-vertical': {
            description:'defines a multiplier against 1em for vertical padding of .button.mini, overriding $button-padding-multiplier-vertical',
            default_value:'0.3',
            type:'decimal'
        },
        'button-padding-multiplier-small-horizontal': {
            description:'defines a multiplier against 1em for horizontal padding of .button.small, overriding $button-padding-multiplier-horizontal',
            default_value:'1',
            type:'decimal'
        },
        'button-padding-multiplier-small-vertical': {
            description:'defines a multiplier against 1em for vertical padding of .button.small, overriding $button-padding-multiplier-vertical',
            default_value:'0.3',
            type:'decimal'
        },
        'button-padding-multiplier-default-horizontal': {
            description:'defines a multiplier against 1em for horizontal padding of .button (without size qualifier), overriding $button-padding-multiplier-horizontal',
            default_value:'1',
            type:'decimal'
        },
        'button-padding-multiplier-default-vertical': {
            description:'defines a multiplier against 1em for vertical padding of .button (without size qualifier), overriding $button-padding-multiplier-vertical',
            default_value:'0.3',
            type:'decimal'
        },
        'button-padding-multiplier-large-horizontal': {
            description:'defines a multiplier against 1em for horizontal padding of .button.large, overriding $button-padding-multiplier-horizontal',
            default_value:'1',
            type:'decimal'
        },
        'button-padding-multiplier-large-vertical': {
            description:'defines a multiplier against 1em for vertical padding of .button.large, overriding $button-padding-multiplier-vertical',
            default_value:'0.3',
            type:'decimal'
        },
        'button-border-radius-multiplier': {
            description:'defines a multiplier against 1em for vertical padding of .button',
            default_value:'0.4',
            type:'decimal'
        },
        'button-border-radius-multiplier-mini': {
            description:'defines a multiplier against 1em for vertical padding of .button.mini, overriding $button-border-radius-multiplier',
            default_value:'0.4',
            type:'decimal'
        },
        'button-border-radius-multiplier-small': {
            description:'defines a multiplier against 1em for vertical padding of .button.small, overriding $button-border-radius-multiplier',
            default_value:'0.4',
            type:'decimal'
        },
        'button-border-radius-multiplier-default': {
            description:'defines a multiplier against 1em for vertical padding of .button (without size qualifier), overriding $button-border-radius-multiplier',
            default_value:'0.4',
            type:'decimal'
        },
        'button-border-radius-multiplier-large': {
            description:'defines a multiplier against 1em for vertical padding of .button.large, overriding $button-border-radius-multiplier',
            default_value:'0.4',
            type:'decimal'
        },
        'button-cursor': {
            description:'defines the cursor shown when hovered over the button',
            default_value:'pointer',
            type:'string'
        },
        'button-boxshadow-hover': {
            description:'box shadow applied when hovered over the button',
            default_value:'#{inset 0 1px 0 rgba(-color-select-first-if-light(255,0),-color-select-first-if-light(255,0),-color-select-first-if-light(255,0),.2), 0 1px 2px rgba(-color-select-first-if-light(0,255),-color-select-first-if-light(0,255),-color-select-first-if-light(0,255),.05)}',
            type:'boxshadow'
        },
        'color-branding-default': {
            description:'defines base for default color',
            default_value:'#eee',
            type:'color'
        },
        'color-branding-primary': {
            description:'defines base for primary color',
            default_value:'#234189',
            type:'color'
        },
        'color-branding-secondary': {
            description:'defines base for secondary color',
            default_value:'#7bc0de',
            type:'color'
        },
        'color-branding-tertiary': {
            description:'defines base for tertiary color',
            default_value:'#eada4d',
            type:'color'
        },
        'color-branding-neutral': {
            description:'defines base for neutral color',
            default_value:'#ccc',
            type:'color'
        },
        'color-body-background': {
            description:'defines body background color',
            default_value:'#fff',
            type:'color'
        },
        'color-body-background-text': {
            description:'defines body text color',
            default_value:'#323232',
            type:'color'
        },
        'color-body-link-text': {
            description:'defines body link color',
            default_value:'#073198',
            type:'color'
        },
        'color-body-link-hover-text': {
            description:'defines body link hover color',
            default_value:'#44557d',
            type:'color'
        },
        'color-mood-info': {
            description:'defines base for info color',
            default_value:'#2d95b3',
            type:'color'
        },
        'color-mood-success': {
            description:'defines base for success color',
            default_value:'#2c8529',
            type:'color'
        },
        'color-mood-warning': {
            description:'defines base for warning color',
            default_value:'#b76420',
            type:'color'
        },
        'color-mood-error': {
            description:'defines base for error color',
            default_value:'#ac3124',
            type:'color'
        },
        'color-mood-danger': {
            description:'defines base for danger color',
            default_value:'#ac3124',
            type:'color'
        },
        'color-mood-inverse': {
            description:'defines base for inverse color',
            default_value:'#222',
            type:'color'
        },
        'color-mood-important': {
            description:'defines base for important color',
            default_value:'#7a3582',
            type:'color'
        },
        'color-mood-required': {
            description:'defines base for required color',
            default_value:'#ab0900',
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
            description:'percentage text is darkened when background below <code>$color-contrast-threshold[-light|-dark]</code> brightness',
            default_value:'80%',
            type:'percent'
        },
        'color-grade-lt-text': {
            description:'percentage text is lightened when background above <code>$color-contrast-threshold[-light|-dark]</code> brightness',
            default_value:'93%',
            type:'percent'
        },
        'color-grade-dk-text-body': {
            description:'percentage body text is darkened when background below <code>$color-contrast-threshold-body</code> brightness',
            default_value:'80%',
            type:'percent'
        },
        'color-grade-lt-text-body': {
            description:'percentage body text is lightened when background above <code>$color-contrast-threshold-body</code> brightness',
            default_value:'93%',
            type:'percent'
        },
        'color-text-brightness': {
            description:'brightness percentage for <code>text-</code> classes',
            default_value:'35%',
            type:'percent'
        },
        'color-background-light-brightness': {
            description:'brightness percentage for <code>.light</code> background color',
            default_value:'92%',
            type:'percent'
        },
        'color-background-shadow-light-brightness': {
            description:'brightness percentage for <code>.light.gradient</code> shadow color',
            default_value:'85%',
            type:'percent'
        },
        'color-light-border-brightness': {
            description:'brightness percentage for light border',
            default_value:'70%',
            type:'percent'
        },
        'color-background-dark-brightness': {
            description:'brightness percentage for <code>.dark</code> background color',
            default_value:'14%',
            type:'percent'
        },
        'color-background-shadow-dark-brightness': {
            description:'brightness percentage for <code>.dark.gradient</code> shadow color',
            default_value:'40%',
            type:'percent'
        },
        'color-dark-border-brightness': {
            description:'brightness percentage for light border',
            default_value:'60%',
            type:'percent'
        },
        'color-contrast-threshold': {
            description:'generic threshold used to select light instead of dark color',
            default_value:'60%',
            type:'percent'
        },
        'color-contrast-threshold-light': {
            description:'generic threshold used to select light instead of dark color for light variant',
            default_value:'60%',
            type:'percent'
        },
        'color-contrast-threshold-dark': {
            description:'generic threshold used to select light instead of dark color for dark variant',
            default_value:'60%',
            type:'percent'
        },
        'color-contrast-threshold-body': {
            description:'generic threshold used to select light instead of dark color for body text',
            default_value:'60%',
            type:'percent'
        },
        'color-contrast-body': {
            description:'true if color is above <code>$color-constrast-threshold-body</code>; can be set explicitly to true to force light as the basis for fade or false to force dark as the basis for fade',
            default_value:'true',
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
        'form-input-font-size': {
            description:'font size for all form inputs',
            default_value:'1em',
            type:'em (recommended), px, percent'
        },
        'form-legend-font-size': {
            description:'font size for all form inputs',
            default_value:'1.5em',
            type:'em (recommended), px, percent'
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
            default_value:'300px',
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
        'form-input-boxshadow': {
            description:'box shadow applied on controls within <code>form.form</code>',
            default_value:'inset 0 1px 1px rgba(0,0,0,.075)',
            type:'boxshadow'
        },
        'form-input-boxshadow-focus': {
            description:'box shadow applied on focused controls within <code>form.form</code>',
            default_value:'#{inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(82,168,236,.6)}',
            type:'boxshadow'
        },
        'form-placeholder-text-color': {
            description:'text color for placeholder text of <code>input, textarea, select</code> within <code>form.form</code>',
            default_value:'lighten($form-input-text-color, 40%)',
            type:'color'
        },
        'nav-breadcrumb-background-color': {
            description: 'color used for the background of the element containing the breadcrumb navigation items',
            default_value: '#F5F5F5',
            type: 'color'
        },
        'nav-breadcrumb-border-radius': {
            description: 'border radius of the element containing the breadcrumb navigation items',
            default_value: '4px',
            type: 'px'
        },
        'nav-breadcrumb-item-link-color': {
            description: 'color of the links within the breadcrumb navigation',
            default_value: '#08C',
            type: 'color'
        },
        'nav-breadcrumb-item-shadow-color': {
            description: 'color of the text shadow on the breadcrumb navigation item text',
            default_value: '#FFF',
            type: 'color'
        },
        'nav-breadcrumb-active-color': {
            description: 'text color of the active breadcrumb navigation item',
            default_value: '#333',
            type: 'color'
        },
        'nav-breadcrumb-divider-color': {
            description: 'text color of the dividers within breadcrumb navigation',
            default_value: '#CCC',
            type: 'color'
        },
        'nav-tabs-border-bottom-color': {
            description: 'border color of the bottom border within tabbed navigation',
            default_value: '#aaa',
            type: 'color'
        },
        'nav-tabs-link-padding-X': {
            description: 'horizontal padding inside a tab within tabbed navigation',
            default_value: '16px',
            type: 'px (recommended), em'
        },
        'nav-tabs-link-padding-Y': {
            description: 'vertical padding inside a tab within tabbed navigation',
            default_value: '8px',
            type: 'px (recommended), em'
        },
        'nav-tabs-link-spacing-before': {
            description: 'horizontal spacing (margin) before each tab within tabbed navigation',
            default_value: '0.5em',
            type: 'em, px'
        },
        'nav-tabs-link-spacing-after': {
            description: 'horizontal spacing (margin) before each tab within tabbed navigation',
            default_value: '0',
            type: 'em, px'
        },
        'nav-tabs-link-border-color': {
            description: 'border color of each tab within tabbed navigation',
            default_value: '#ccc',
            type: 'color'
        },
        'nav-tabs-link-border-radius': {
            description: 'border radius of each tab within tabbed navigation',
            default_value: '8px',
            type: 'em, px'
        },
        'nav-tabs-link-background-color': {
            description: 'border color of each tab within tabbed navigation',
            default_value: '#fbfbfb',
            type: 'color'
        },
        'nav-tabs-link-active-border-color': {
            description: 'border color of the current active tab within tabbed navigation',
            default_value: '#aaa',
            type: 'color'
        },
        'nav-tabs-link-active-background-color': {
            description: 'border color of the current active tab within tabbed navigation',
            default_value: '#fff',
            type: 'color'
        },
        'nav-tabs-link-hover-border-color': {
            description: 'border color of the current hovered tab within tabbed navigation',
            default_value: '#aaa',
            type: 'color'
        },
        'nav-tabs-link-hover-background-color': {
            description: 'border color of the current hovered tab within tabbed navigation',
            default_value: '#fff',
            type: 'color'
        },
        'blockquote-small-color': {
            description: 'color of text in blockquote wrapped by &lt;small&gt; tags',
            default_value: '#666',
            type: 'color'
        },
        'blockquote-border-color': {
            description: 'color of border in blockquote',
            default_value: '#b3b3b3',
            type: 'color'
        },
        'message-border-radius': {
            description:'border radius of <code>.message</code>',
            default_value:'5px',
            type:'px'
        },
        'message-header-color-brightness-difference-light': {
            description: 'color computation value to determine color brightness for light color backgrounds',
            default_value: '12%',
            type:'percent'
        },
        'message-header-color-brightness-difference-dark': {
            description: 'color computation value to determine color brightness for dark color backgrounds',
            default_value: '4%',
            type:'percent'
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
    
    DOC.vars.sass.get_all = function(){
        return $.extend(true, {}, sass_vars)
    }
    
    DOC.vars.sass.get = function(name){
        return $.extend(true, {}, sass_vars[name])
    }

    DOC.vars.sass.render = function(name){
        var variableView = new EJS({url: 'component/variable.ejs'}), 
            data = sass_vars[name]
        data.name = name
        return variableView.render(data)
    }
    
    DOC.vars.sass.render_control = function(name){
        var controlView = new EJS({url: 'component/control.ejs'}), 
            data = {}
        data.label_text = name
        data.input_type = 'text'
        data.input_name = name
        data.input_id = name
        data.input_value = typeof sass_vars[name]['default_value'] != 'undefined'
                           ? sass_vars[name]['default_value']
                           : ''
        data.help_text = sass_vars[name].description;
        if(typeof sass_vars[name]['default_value'] != 'undefined')
            data.help_text += ' [default: '+sass_vars[name]['default_value']+']'
        return controlView.render(data)
    }
    
})();