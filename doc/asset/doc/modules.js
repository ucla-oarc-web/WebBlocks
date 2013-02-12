(function(){
    
    var modules = {
        
        'Base/Structure/Grid': {
            description:'Defines a set of classes including <code>.row</code>, <code>.panel-X</code> and <code>.Y-collapse</code>. These may be used to specify grid layouts for an application whereby, at a particular breakpoint, the row collapses to a vertically-oriented set of elements.',
            defines:{
                '.row':'Container for a set of panels', 
                '.panel-X':'Panels arranged proportionally as <code>X/$structure-panels</code>'
            }
        }, 
        
        'Base/Structure/Container': {
            description:'Defines the <code>.container</code> class. This class may be used on an element to define a maximum size it may grow to in large viewports, as well as ensure padding of the content on small viewports',
            defines:{
                '.container':'Container with max width and min margin support'
            }
        },
        
        'Base/Block/Float': {
            description:'Provides utility classes that can apply a float, clear a float, or wrap floated element(s) within a container so that elements positioned later in the DOM will be flowed below all of the contained elements.',
            define:{
                '.float-left':'Float a block-level element to the left',
                '.float-right':'Float a block-level element to the right',
                '.float-clear':'Clear floated elements',
                '.float-container':'Container for floats using <code>overflow:hidden</code>',
                '.clearfix':'Container for floats using a clearfixing method'
            }
        },
        'Base/Type/Align': {
            description:'Provides classes that modify the alignment of type within contained elements.',
            define:{
                '.text-left':'Left-align text',
                '.text-center':'Center text',
                '.text-right':'Right-align text',
                '.text-justify':'Justify text',
            }
        },
        'Base/Type/Font': {
            description:'Provides a basic set of font styles.'
        },
        'Base/Visibility/Hide': {
            description:'Defines a <code>.hide</code> class for hiding content universally',
            define:{
                '.hide':'Universally hide content'
            }
        },
        'Base/Visibility/Media_Query/Hide': {
            description:'Defines a <code>.hide-media-query</code> class to hide content when media queries are available.',
            define:{
                '.hide-media-query':'Hide content if media query support exists'
            }
        },
        'Base/Visibility/Responsive/Hide': {
            description:'Defines a set of <code>.hide-X</code> classes that set content to be hidden at and below a particular breakpoint.',
            define: {
                '.hide-xxsmall':'Hide content at and below <code>$beakpoint-xxsmall</code>',
                '.hide-xsmall':'Hide content at and below <code>$beakpoint-xsmall</code>',
                '.hide-small':'Hide content at and below <code>$beakpoint-small</code>',
                '.hide-medium-small':'Hide content at and below <code>$beakpoint-medium-small</code>',
                '.hide-medium':'Hide content at and below <code>$beakpoint-medium</code>',
                '.hide-medium-large':'Hide content at and below <code>$beakpoint-medium-large</code>',
                '.hide-large':'Hide content at and below <code>$beakpoint-large</code>'
            }
        },
        'Base/Visibility/Responsive/Hide_Above': {
            description:'Defines a set of <code>.hide-above-X</code> classes that set content to be hidden when viewport is <em>larger</em> than a particular breakpoint.',
            define: {
                '.hide-above-xxsmall':'Hide content above <code>$beakpoint-xxsmall</code>',
                '.hide-above-xsmall':'Hide content above <code>$beakpoint-xsmall</code>',
                '.hide-above-small':'Hide content above <code>$beakpoint-small</code>',
                '.hide-above-medium-small':'Hide content above <code>$beakpoint-medium-small</code>',
                '.hide-above-medium':'Hide content above <code>$beakpoint-medium</code>',
                '.hide-above-medium-large':'Hide content above <code>$beakpoint-medium-large</code>',
                '.hide-above-large':'Hide content above <code>$beakpoint-large</code>'
            }
        }
    }

    DOC.modules.render = function(name){
        var view = new EJS({url: 'component/module/basic.ejs'}), 
            data = modules[name]
        data.name = name
        if(data.define){
            var definitions = []
            for(var i in data.define)
                definitions.push(i)
            data.definitions = definitions.join(', ')
        }
        return view.render(data)
    }
    
})();