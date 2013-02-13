(function(){
    
    var modules = {
        
        'Base/Block/Float': {
            description:'Provides utility classes that can apply a float, clear a float, or wrap floated element(s) within a container so that elements positioned later in the DOM will be flowed below all of the contained elements.',
            defines:{
                '.float-left':'Float a block-level element to the left',
                '.float-right':'Float a block-level element to the right',
                '.float-clear':'Clear floated elements',
                '.float-container':'Container for floats using <code>overflow:hidden</code>',
                '.clearfix':'Container for floats using a clearfixing method'
            }
        },
        'Base/Color/Branding/Background': {
            description:'Defines a set of color classes that may be used for brand-related background colors.',
            defines:{
                '.primary':'Primary brand background color',
                '.secondary':'Secondary brand background color',
                '.tertiary':'Tertiary brand background color',
                '.neutral':'Neutral brand background color',
                '.gradient':'Applies gradient to brand background color'
            }
        },
        'Base/Color/Branding/Background_Gradient': {
            description:'Defines a set of gradient color classes that may be used for brand-related background colors.',
            defines:{
                '.primary.gradient':'Primary gradient brand background color',
                '.secondary.gradient':'Secondary gradient brand background color',
                '.tertiary.gradient':'Tertiary gradient brand background color',
                '.neutral.gradient':'Neutral gradient brand background color'
            }
        },
        'Base/Color/Branding/Background_Light': {
            description:'Defines a set of light color classes that may be used for brand-related background colors.',
            defines:{
                '.primary.light':'Light primary brand background color',
                '.secondary.light':'Light secondary brand background color',
                '.tertiary.light':'Light tertiary brand background color',
                '.neutral.light':'Light neutral brand background color'
            }
        },
        'Base/Color/Branding/Background_Light_Gradient': {
            description:'Defines a set of light gradient color classes that may be used for brand-related background colors.',
            defines:{
                '.primary.light.gradient':'Light primary gradient brand background color',
                '.secondary.light.gradient':'Light secondary gradient brand background color',
                '.tertiary.light.gradient':'Light tertiary gradient brand background color',
                '.neutral.light.gradient':'Light neutral gradient brand background color'
            }
        },
        'Base/Color/Branding/Text': {
            description:'Defines a set of color classes that may be used for brand-related text colors.',
            defines:{
                '.text-primary':'Primary brand text color',
                '.text-secondary':'Secondary brand text color',
                '.text-tertiary':'Tertiary brand text color',
                '.text-neutral':'Neutral brand text color'
            }
        },
        'Base/Color/Mood/Background': {
            description:'Defines a set of color classes that may be used for mood-related background colors.',
            defines:{
                '.info':'Info mood background color',
                '.success':'Success mood background color',
                '.warning':'Warning mood background color',
                '.error':'Error mood background color',
                '.danger':'Danger mood background color',
                '.important':'Important mood background color',
                '.inverse':'Inverse mood background color',
                '.required':'Required mood background color',
                '.highlight':'Highlight mood background color'
            }
        },
        'Base/Color/Mood/Background_Gradient': {
            description:'Defines a set of gradient color classes that may be used for mood-related background colors.',
            defines:{
                '.info.gradient':'Info gradient mood background color',
                '.success.gradient':'Success gradient mood background color',
                '.warning.gradient':'Warning gradient mood background color',
                '.error.gradient':'Error gradient mood background color',
                '.danger.gradient':'Danger gradient mood background color',
                '.important.gradient':'Important gradient mood background color',
                '.inverse.gradient':'Inverse gradient mood background color',
                '.required.gradient':'Required gradient mood background color',
                '.highlight.gradient':'Highlight gradient mood background color'
            }
        },
        'Base/Color/Mood/Background_Light': {
            description:'Defines a set of light color classes that may be used for mood-related background colors.',
            defines:{
                '.info.light':'Light info mood background color',
                '.success.light':'Light success mood background color',
                '.warning.light':'Light warning mood background color',
                '.error.light':'Light error mood background color',
                '.danger.light':'Light danger mood background color',
                '.important.light':'Light important mood background color',
                '.inverse.light':'Light inverse mood background color',
                '.required.light':'Light required mood background color',
                '.highlight.light':'Light highlight mood background color'
            }
        },
        'Base/Color/Mood/Background_Light_Gradient': {
            description:'Defines a set of light gradient color classes that may be used for mood-related background colors.',
            defines:{
                '.info.light.gradient':'Light info gradient mood background color',
                '.success.light.gradient':'Light success gradient mood background color',
                '.warning.light.gradient':'Light warning gradient mood background color',
                '.error.light.gradient':'Light error gradient mood background color',
                '.danger.light.gradient':'Light danger gradient mood background color',
                '.important.light.gradient':'Light important gradient mood background color',
                '.inverse.light.gradient':'Light inverse gradient mood background color',
                '.required.light.gradient':'Light required gradient mood background color',
                '.highlight.light.gradient':'Light highlight gradient mood background color'
            }
        },
        'Base/Color/Mood/Text': {
            description:'Defines a set of color classes that may be used for mood-related text colors.',
            defines:{
                '.text-info':'Info mood text color',
                '.text-success':'Success mood text color',
                '.text-warning':'Warning mood text color',
                '.text-error':'Error mood text color',
                '.text-danger':'Danger mood text color',
                '.text-important':'Important mood text color',
                '.text-inverse':'Inverse mood text color',
                '.text-required':'Required mood text color',
                '.text-highlight':'Highlight mood text color'
            }
        },
        'Base/Structure/Grid': {
            description:'Defines a set of classes that may be used to specify grid layouts for an application whereby, at a particular breakpoint, the row panels collapse to a vertically-oriented set of elements.',
            defines:{
                '.row':'Container for a set of panels', 
                '.panel-X':'Panels arranged proportionally as <code>X/$structure-panels</code>',
                '.row.Y-collapse':'Explicitly define when the panels in a row collapse to vertical inline'
            },
            uses:[
                'structure-panels',
                'structure-panel-gutter',
                'breakpoint-xxsmall',
                'breakpoint-xsmall',
                'breakpoint-small',
                'breakpoint-medium-small',
                'breakpoint-medium',
                'breakpoint-medium-large',
                'breakpoint-large'
            ]
        }, 
        
        'Base/Structure/Container': {
            description:'Defines a container class may be used on an element to define a maximum size it may grow to in large viewports, as well as ensure padding of the content on small viewports.',
            defines:{
                '.container':'Container with max width and min margin support'
            },
            uses:[
                'structure-container-gutter',
                'structure-container-width-max'
            ]
        },
        'Base/Type/Align': {
            description:'Provides classes that modify the alignment of type within contained elements.',
            defines:{
                '.text-left':'Left-align text',
                '.text-center':'Center text',
                '.text-right':'Right-align text',
                '.text-justify':'Justify text',
            }
        },
        'Base/Type/Font': {
            description:'Provides a basic set of font styles.',
            uses:[
                'type-font-family',
                'type-font-size',
                'type-font-size-small',
                'type-font-size-h1',
                'type-font-size-h2',
                'type-font-size-h3',
                'type-font-size-h4',
                'type-font-size-h5',
                'type-font-size-h6',
                'type-font-size-h1-small',
                'type-font-size-h2-small',
                'type-font-size-h3-small',
                'type-font-size-h4-small',
                'type-font-size-h5-small',
                'type-font-size-h6-small',
                'type-line-spacing',
                'type-line-height',
                'type-line-height-heading'
            ]
        },
        'Base/Visibility/Hide': {
            description:'Defines a class for hiding content universally',
            defines:{
                '.hide':'Universally hide content'
            }
        },
        'Base/Visibility/Media_Query/Hide': {
            description:'Defines a class to hide content when media queries are available.',
            defines:{
                '.hide-media-query':'Hide content if media query support exists'
            }
        },
        'Base/Visibility/Responsive/Hide': {
            description:'Defines a set of classes that set content to be hidden at and below a particular breakpoint.',
            defines: {
                '.hide-xxsmall':'Hide content at and below <code>$beakpoint-xxsmall</code>',
                '.hide-xsmall':'Hide content at and below <code>$beakpoint-xsmall</code>',
                '.hide-small':'Hide content at and below <code>$beakpoint-small</code>',
                '.hide-medium-small':'Hide content at and below <code>$beakpoint-medium-small</code>',
                '.hide-medium':'Hide content at and below <code>$beakpoint-medium</code>',
                '.hide-medium-large':'Hide content at and below <code>$beakpoint-medium-large</code>',
                '.hide-large':'Hide content at and below <code>$beakpoint-large</code>'
            },
            uses:[
                'breakpoint-xxsmall',
                'breakpoint-xsmall',
                'breakpoint-small',
                'breakpoint-medium-small',
                'breakpoint-medium',
                'breakpoint-medium-large',
                'breakpoint-large'
            ]
        },
        'Base/Visibility/Responsive/Hide_Above': {
            description:'Defines a set of classes that set content to be hidden when viewport is <em>larger</em> than a particular breakpoint.',
            defines: {
                '.hide-above-xxsmall':'Hide content above <code>$beakpoint-xxsmall</code>',
                '.hide-above-xsmall':'Hide content above <code>$beakpoint-xsmall</code>',
                '.hide-above-small':'Hide content above <code>$beakpoint-small</code>',
                '.hide-above-medium-small':'Hide content above <code>$beakpoint-medium-small</code>',
                '.hide-above-medium':'Hide content above <code>$beakpoint-medium</code>',
                '.hide-above-medium-large':'Hide content above <code>$beakpoint-medium-large</code>',
                '.hide-above-large':'Hide content above <code>$beakpoint-large</code>'
            },
            uses:[
                'breakpoint-xxsmall',
                'breakpoint-xsmall',
                'breakpoint-small',
                'breakpoint-medium-small',
                'breakpoint-medium',
                'breakpoint-medium-large',
                'breakpoint-large'
            ]
        },
        'Entity/Badge': {
            description:'Defines a user interface class that can be used on an inline element to highlighted a set of text as a badge (sometimes alternatively referred to as a label), optionally with a branding or mood color and other stylistic attributes.',
            defines: {
                '.badge':'Styles an inline element as a badge',
                '.badge.round':'Styles an inline element as a pill-shaped badge',
                '.badge.square':'Styles an inline element as a square badge'
            },
            supports: [
                '.primary',
                '.secondary',
                '.tertiary',
                '.neutral',
                '.info',
                '.success',
                '.warning',
                '.danger',
                '.important',
                '.inverse',
                '.required',
                '.highlight'
            ]
        },
        'Entity/Blockquote': {
            description:'Defines a user interface class that can be used on an inline element to highlighted a set of text as a badge (sometimes alternatively referred to as a label), optionally with a branding or mood color and other stylistic attributes.',
            defines: {
                'blockquote.blockquote':'Styles a blockquote element, optionally containing a <code>cite</code> element',
                'figure.blockquote':'Styles a figure as an HTML5 blockquote containing a <code>blockquote</code> element and optionally a <code>figcaption</code> element',
                '.blockquote.callout':'Styles a quote that is called out of the flow rather than presented as a full-width block element.'
            },
            supports: [
                '.text-right'
            ]
        },
        'Entity/Button': {
            description:'Defines a button user interface class, along with supporting styling classes, that present an element can be pressed to cause some action within the application.',
            defines: {
                'a.button':'Styles <code>a</code> tag as button',
                'button.button':'Styles <code>a</code> tag as button',
                'input[type="button"].button':'Styles <code>a</code> tag as button',
                'input[type="reset"].button':'Styles <code>a</code> tag as button',
                'input[type="submit"].button':'Styles <code>a</code> tag as button',
                '.button.mini':'Mini version of the button element',
                '.button.small':'Small version of the button element',
                '.button.large':'Large version of the button element'
            },
            submodules: {
                'Entity/Button/A_Button':'defines classes for <code>a</code> tag',
                'Entity/Button/Button':'defines classes for <code>button</code> tag',
                'Entity/Button/Input_Button':'defines classes for button <code>input</code> tag',
                'Entity/Button/Input_Reset':'defines classes for reset <code>input</code> tag',
                'Entity/Button/Input_Submit':'defines classes for submit <code>input</code> tag'
            },
            supports: [
                '.primary',
                '.secondary',
                '.tertiary',
                '.neutral',
                '.info',
                '.success',
                '.warning',
                '.danger',
                '.important',
                '.inverse',
                '.required',
                '.highlight'
            ]
        },
        'Entity/Button/Group': {
            description:'Defines a class that can be used to group buttons. The <code>.group</code> class itself is part of a meta-pattern used by several modules to bind common elements.',
            defines: {
                '.group > .button':'Component of a button group'
            },
            submodules: {
                'Entity/Button/Group/A_Button':'defines group class for <code>a</code> tag',
                'Entity/Button/Group/Button':'defines group class for <code>button</code> tag',
                'Entity/Button/Group/Input_Button':'defines group class for button <code>input</code> tag',
                'Entity/Button/Group/Input_Reset':'defines group class for reset <code>input</code> tag',
                'Entity/Button/Group/Input_Submit':'defines group class for submit <code>input</code> tag'
            }
        },
        'Entity/List': {
            description:'Defines classes that can be used to style ordered and unordered lists.',
            defines: {
                'ul.list':'Basic unordered list styling',
                'ol.list':'Basic ordered list styling',
                'ul.list.unstyled':'Unordered list without styles or padding',
                'ul.list.unstyled':'Ordered list without styles or padding',
                'ol.list.lower-roman':'An ordered list with upper Roman numbering',
                'ol.list.upper-roman':'An ordered list with lower Roman numbering',
                'ol.list.lower-alpha':'An ordered list with upper alpha numbering',
                'ol.list.upper-alpha':'An ordered list with lower alpha numbering',
                'ol.list.outline':'An ordered list with sublists using alternating list numberings'
            }
        },
        'Entity/Message': {
            description:'Defines a user interface class that can be used on a block-level element to display it as a message box, optionally with a branding or mood color.',
            defines: {
                '.message':'Styles a block as a message'
            },
            supports: [
                '.primary',
                '.secondary',
                '.tertiary',
                '.neutral',
                '.info',
                '.success',
                '.warning',
                '.danger',
                '.important',
                '.inverse',
                '.required',
                '.highlight'
            ]
        },
        'Entity/Table': {
            description:'Defines a user interface class that can be used to style a table, representing tabular data.',
            defines: {
                '.table':'',
                '.table.hover':'',
                '.table.striped':'',
                '.table.bordered':'',
                '.table.condensed':''
            },
            supports: [
                '.primary',
                '.secondary',
                '.tertiary',
                '.neutral',
                '.info',
                '.success',
                '.warning',
                '.danger',
                '.important',
                '.inverse',
                '.required',
                '.highlight'
            ],
            uses:[
                'table-caption-text-color',
                'table-border-color',
                'table-cell-padding',
                'table-condensed-cell-padding',
                'table-hover-background-color',
                'table-striped-background-color',
                'table-bordered-border-radius'
            ]
        }
    }

    DOC.modules.render = function(name){
        var view = new EJS({url: 'component/module/basic.ejs'}), 
            data = $.extend(true, {}, modules[name])
        data.name = name
        if(data.defines){
            var definitions = []
            for(var i in data.defines)
                definitions.push(i)
            data.definitions = definitions.join(', ')
        }
        return view.render(data)
    }

    DOC.modules.render_details = function(name){
        var view = new EJS({url: 'component/module/details.ejs'}), 
            data = $.extend(true, {}, modules[name])
        data.name = name
        if(data.defines){
            var definitions = []
            for(var i in data.defines)
                definitions.push(i)
            data.definitions = definitions.join(', ')
        }
        if(data.uses){
            var uses_variables = []
            for(var i in data.uses)
                uses_variables.push(data.uses[i])
            data.uses = uses_variables.join(', ')
        }
        if(data.submodules){
            var submodules_list = []
            for(var i in data.submodules)
                submodules_list.push(i)
            data.submodules = submodules_list.join(', ')
        }
        if(data.supports){
            var supported_classes = []
            for(var i in data.supports)
                supported_classes.push(data.supports[i])
            data.supports = supported_classes.join(', ')
        }
        return view.render(data)
    }
    
    DOC.modules.render_variables = function(name){
        if(!modules[name]['uses'])
            return []
        var uses = modules[name]['uses'],
            variables = []
        for(var i in uses)
            variables.push(DOC.vars.sass.render(uses[i]))
        return variables
    }
    
})();