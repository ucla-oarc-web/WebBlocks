(function(){
    
    var modules = {
        
        'Base/Structure/Grid': {
            description:'Defines a set of classes that may be used to specify grid layouts for an application whereby, at a particular breakpoint, the row panels collapse to a vertically-oriented set of elements.',
            defines:{
                '.row':'Container for a set of panels', 
                '.panel-X':'Panels arranged proportionally as <code>X/$structure-panels</code>',
                '.Y-collapse':'Explicitly define when the panels in a row collapse to vertical inline'
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
        }
    }

    DOC.modules.render = function(name){
        var view = new EJS({url: 'component/module/basic.ejs'}), 
            data = modules[name]
        data.name = name
        if(data.defines){
            var definitions = []
            for(var i in data.defines)
                definitions.push(i)
            data.definitions = definitions.join(', ')
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