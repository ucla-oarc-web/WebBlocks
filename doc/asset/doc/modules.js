(function(){
    
	DOC.modules.getAll = function(){
		
		var modules = {

			'Base': {
				description:'Defines a set of foundation and utility classes'
			},
			'Base/Block': {
				description:'Defines a set of utility classes for managing blocks'
			},
			'Base/Block/Float': {
				description:'Provides utility classes that can apply a float, clear a float, or wrap floated element(s) within a container so that elements positioned later in the DOM will be flowed below all of the contained elements.',
				defines:{
					'.float-left':'Float a block-level element to the left',
					'.float-right':'Float a block-level element to the right',
					'.float-clear':'Clear floated elements',
					'.float-container':'Container for floats using <code>overflow:hidden</code>',
					'.clearfix':'Container for floats using a clearfixing method'
				},
				api:'Base/Block'
			},
			'Base/Block/Float/Responsive': {
				description:'Defines a set of classes that set content to be floated at and below a particular breakpoint.',
				defines: {
					'.float-left-xxsmall':'Float content left at and below <code>$beakpoint-xxsmall</code>',
					'.float-left-xsmall':'Float content left at and below <code>$beakpoint-xsmall</code>',
					'.float-left-small':'Float content left at and below <code>$beakpoint-small</code>',
					'.float-left-medium-small':'Float content left at and below <code>$beakpoint-medium-small</code>',
					'.float-left-medium':'Float content left at and below <code>$beakpoint-medium</code>',
					'.float-left-medium-large':'Float content left at and below <code>$beakpoint-medium-large</code>',
					'.float-left-large':'Float content left at and below <code>$beakpoint-large</code>',
                    '.float-right-xxsmall':'Float content right at and below <code>$beakpoint-xxsmall</code>',
					'.float-right-xsmall':'Float content right at and below <code>$beakpoint-xsmall</code>',
					'.float-right-small':'Float content right at and below <code>$beakpoint-small</code>',
					'.float-right-medium-small':'Float content right at and below <code>$beakpoint-medium-small</code>',
					'.float-right-medium':'Float content right at and below <code>$beakpoint-medium</code>',
					'.float-right-medium-large':'Float content right at and below <code>$beakpoint-medium-large</code>',
					'.float-right-large':'Float content right at and below <code>$beakpoint-large</code>'
				},
				uses:[
					'breakpoint-xxsmall',
					'breakpoint-xsmall',
					'breakpoint-small',
					'breakpoint-medium-small',
					'breakpoint-medium',
					'breakpoint-medium-large',
					'breakpoint-large'
				],
				api:'Base/Block/Float'
			},
			'Base/Block/Float/Responsive_Above': {
				description:'Defines a set of classes that set content to be hidden when viewport is <em>larger</em> than a particular breakpoint.',
				defines: {
					'.float-left-above-xxsmall':'Float content left above <code>$beakpoint-xxsmall</code>',
					'.float-left-above-xsmall':'Float content left above <code>$beakpoint-xsmall</code>',
					'.float-left-above-small':'Float content left above <code>$beakpoint-small</code>',
					'.float-left-above-medium-small':'Float content left above <code>$beakpoint-medium-small</code>',
					'.float-left-above-medium':'Float content left above <code>$beakpoint-medium</code>',
					'.float-left-above-medium-large':'Float content left above <code>$beakpoint-medium-large</code>',
					'.float-left-above-large':'Float content left above <code>$beakpoint-large</code>',
                    '.float-right-above-xxsmall':'Float content right above <code>$beakpoint-xxsmall</code>',
					'.float-right-above-xsmall':'Float content right above <code>$beakpoint-xsmall</code>',
					'.float-right-above-small':'Float content right above <code>$beakpoint-small</code>',
					'.float-right-above-medium-small':'Float content right above <code>$beakpoint-medium-small</code>',
					'.float-right-above-medium':'Float content right above <code>$beakpoint-medium</code>',
					'.float-right-above-medium-large':'Float content right above <code>$beakpoint-medium-large</code>',
					'.float-right-above-large':'Float content right above <code>$beakpoint-large</code>'
				},
				uses:[
					'breakpoint-xxsmall',
					'breakpoint-xsmall',
					'breakpoint-small',
					'breakpoint-medium-small',
					'breakpoint-medium',
					'breakpoint-medium-large',
					'breakpoint-large'
				],
				api:'Base/Block/Float'
			},
			'Base/Color': {
				description:'Defines a set of brand-related and mood-related colors for text and backgrounds'
			},
			'Base/Color/Branding': {
				description:'Defines a set of brand-related colors for text and backgrounds'
			},
			'Base/Color/Branding/Background': {
				description:'Defines a set of color classes that may be used for brand-related background colors.',
				defines:{
					'.primary':'Primary brand background color',
					'.secondary':'Secondary brand background color',
					'.tertiary':'Tertiary brand background color',
					'.neutral':'Neutral brand background color',
					'.gradient':'Applies gradient to brand background color'
				},
				api:'Base/Color'
			},
			'Base/Color/Branding/Background_Gradient': {
				description:'Defines a set of gradient color classes that may be used for brand-related background colors.',
				defines:{
					'.primary.gradient':'Primary gradient brand background color',
					'.secondary.gradient':'Secondary gradient brand background color',
					'.tertiary.gradient':'Tertiary gradient brand background color',
					'.neutral.gradient':'Neutral gradient brand background color'
				},
				requires: [
					'Base/Color/Branding/Background'
				],
				api:'Base/Color'
			},
			'Base/Color/Branding/Background_Light': {
				description:'Defines a set of light color classes that may be used for brand-related background colors.',
				defines:{
					'.primary.light':'Light primary brand background color',
					'.secondary.light':'Light secondary brand background color',
					'.tertiary.light':'Light tertiary brand background color',
					'.neutral.light':'Light neutral brand background color'
				},
				api:'Base/Color'
			},
			'Base/Color/Branding/Background_Light_Gradient': {
				description:'Defines a set of light gradient color classes that may be used for brand-related background colors.',
				defines:{
					'.primary.light.gradient':'Light primary gradient brand background color',
					'.secondary.light.gradient':'Light secondary gradient brand background color',
					'.tertiary.light.gradient':'Light tertiary gradient brand background color',
					'.neutral.light.gradient':'Light neutral gradient brand background color'
				},
				requires: [
					'Base/Color/Branding/Background_Light'
				],
				api:'Base/Color'
			},
			'Base/Color/Branding/Text': {
				description:'Defines a set of color classes that may be used for brand-related text colors.',
				defines:{
					'.text-primary':'Primary brand text color',
					'.text-secondary':'Secondary brand text color',
					'.text-tertiary':'Tertiary brand text color',
					'.text-neutral':'Neutral brand text color'
				},
				api:'Base/Color'
			},
			'Base/Color/Mood': {
				description:'Defines a set of mood-related colors for text and backgrounds'
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
				},
				api:'Base/Color'
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
				},
				requires: [
					'Base/Color/Mood/Background'
				],
				api:'Base/Color'
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
				},
				api:'Base/Color'
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
				},
				requires: [
					'Base/Color/Mood/Background_Light'
				],
				api:'Base/Color'
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
				},
				api:'Base/Color'
			},
			'Base/Color/Text': {
				description: 'Encapsulates mood and branding text colors in a mixin -import-base-color-text',
				requires: [
					'Base/Color/Branding/Text',
					'Base/Color/Mood/Text'
				],
				api:'Base/Color'
			},
			'Base/Normalize': {
				description: 'Normalizes user agent stylesheets to reduce browser discrepancies and estabish a style baseline'
			},
			'Base/Structure': {
				description:'Defines structural classes including a fluid grid, container and constrained content.'
			},
			'Base/Structure/Grid': {
				description:'Defines a set of classes that may be used to specify grid layouts for an application whereby, at a particular breakpoint, the row panels collapse to a vertically-oriented set of elements.',
				defines:{
					'.row':'Container for a set of panels', 
					'.row > .panel-X':'Panels arranged proportionally as <code>X/$structure-panels</code>',
					'.row.xxsmall-collapse':'Explicitly set row to collapse at <code>$breakpoint-xxsmall</code>',
					'.row.xsmall-collapse':'Explicitly set row to collapse at <code>$breakpoint-xsmall</code>',
					'.row.small-collapse':'Explicitly set row to collapse at <code>$breakpoint-small</code>',
					'.row.medium-small-collapse':'Explicitly set row to collapse at <code>$breakpoint-medium-small</code>',
					'.row.medium-collapse':'Explicitly set row to collapse at <code>$breakpoint-medium</code>',
					'.row.medium-large-collapse':'Explicitly set row to collapse at <code>$breakpoint-medium-large</code>',
					'.row.large-collapse':'Explicitly set row to collapse at <code>$breakpoint-large</code>'
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
				],
				api:'Base/Structure/Grid'
			}, 
			'Base/Structure/Container': {
				description:'Defines a container class may be used on an element to define a maximum size it may grow to in large viewports, as well as ensure padding of the content on small viewports.',
				defines:{
					'.container':'Container with max width and min margin support'
				},
				uses:[
					'structure-container-gutter',
					'structure-container-width-max'
				],
				api:'Base/Structure/Container'
			},
			'Base/Structure/Constrained': {
				description:'Defines a helper class which constrains the max-width of the element to no greater than 100% of the size of the parent element.',
				defines:{
					'.constrained':'Element is constrained to 100% the max-width of the container'
				},
				api:'Base/Structure/Constrained'
			},
			'Base/Type': {
				description:'Defines typographical utility classes.'
			},
			'Base/Type/Align': {
				description:'Provides classes that modify the alignment of type within contained elements.',
				defines:{
					'.text-left':'Left-align text',
					'.text-center':'Center text',
					'.text-right':'Right-align text',
					'.text-justify':'Justify text',
				},
				api:'Base/Type'
			},
			'Base/Type/Align/Responsive': {
				description:'Defines a set of classes that set text to be aligned at and below a particular breakpoint.',
				defines: {
					'.text-left-xxsmall':'Left-align text at and below <code>$beakpoint-xxsmall</code>',
					'.text-left-xsmall':'Left-align text at and below <code>$beakpoint-xsmall</code>',
					'.text-left-small':'Left-align text at and below <code>$beakpoint-small</code>',
					'.text-left-medium-small':'Left-align text at and below <code>$beakpoint-medium-small</code>',
					'.text-left-medium':'Left-align text at and below <code>$beakpoint-medium</code>',
					'.text-left-medium-large':'Left-align text at and below <code>$beakpoint-medium-large</code>',
					'.text-left-large':'Left-align text at and below <code>$beakpoint-large</code>',
                    '.text-center-xxsmall':'Center-align text at and below <code>$beakpoint-xxsmall</code>',
					'.text-center-xsmall':'Center-align text at and below <code>$beakpoint-xsmall</code>',
					'.text-center-small':'Center-align text at and below <code>$beakpoint-small</code>',
					'.text-center-medium-small':'Center-align text at and below <code>$beakpoint-medium-small</code>',
					'.text-center-medium':'Center-align text at and below <code>$beakpoint-medium</code>',
					'.text-center-medium-large':'Center-align text at and below <code>$beakpoint-medium-large</code>',
					'.text-center-large':'Center-align text at and below <code>$beakpoint-large</code>',
					'.text-right-xxsmall':'Right-align text at and below <code>$beakpoint-xxsmall</code>',
					'.text-right-xsmall':'Right-align text at and below <code>$beakpoint-xsmall</code>',
					'.text-right-small':'Right-align text at and below <code>$beakpoint-small</code>',
					'.text-right-medium-small':'Right-align text at and below <code>$beakpoint-medium-small</code>',
					'.text-right-medium':'Right-align text at and below <code>$beakpoint-medium</code>',
					'.text-right-medium-large':'Right-align text at and below <code>$beakpoint-medium-large</code>',
					'.text-right-large':'Right-align text at and below <code>$beakpoint-large</code>',
                    '.text-justify-xxsmall':'Justify text at and below <code>$beakpoint-xxsmall</code>',
					'.text-justify-xsmall':'Justify text at and below <code>$beakpoint-xsmall</code>',
					'.text-justify-small':'Justify text at and below <code>$beakpoint-small</code>',
					'.text-justify-medium-small':'Justify text at and below <code>$beakpoint-medium-small</code>',
					'.text-justify-medium':'Justify text at and below <code>$beakpoint-medium</code>',
					'.text-justify-medium-large':'Justify text at and below <code>$beakpoint-medium-large</code>',
					'.text-justify-large':'Justify text at and below <code>$beakpoint-large</code>'
				},
				uses:[
					'breakpoint-xxsmall',
					'breakpoint-xsmall',
					'breakpoint-small',
					'breakpoint-medium-small',
					'breakpoint-medium',
					'breakpoint-medium-large',
					'breakpoint-large'
				],
				api:'Base/Type'
			},
			'Base/Type/Align/Responsive_Above': {
				description:'Defines a set of classes that set text to be aligned when viewport is <em>larger</em> than a particular breakpoint.',
				defines: {
					'.text-left-above-xxsmall':'Left-align text above <code>$beakpoint-xxsmall</code>',
					'.text-left-above-xsmall':'Left-align text above <code>$beakpoint-xsmall</code>',
					'.text-left-above-small':'Left-align text above <code>$beakpoint-small</code>',
					'.text-left-above-medium-small':'Left-align text above <code>$beakpoint-medium-small</code>',
					'.text-left-above-medium':'Left-align text above <code>$beakpoint-medium</code>',
					'.text-left-above-medium-large':'Left-align text above <code>$beakpoint-medium-large</code>',
					'.text-left-above-large':'Left-align text above <code>$beakpoint-large</code>',
                    '.text-center-above-xxsmall':'Center-align text above <code>$beakpoint-xxsmall</code>',
					'.text-center-above-xsmall':'Center-align text above <code>$beakpoint-xsmall</code>',
					'.text-center-above-small':'Center-align text above <code>$beakpoint-small</code>',
					'.text-center-above-medium-small':'Center-align text above <code>$beakpoint-medium-small</code>',
					'.text-center-above-medium':'Center-align text above <code>$beakpoint-medium</code>',
					'.text-center-above-medium-large':'Center-align text above <code>$beakpoint-medium-large</code>',
					'.text-center-above-large':'Center-align text above <code>$beakpoint-large</code>',
                    '.text-right-above-xxsmall':'Right-align text above <code>$beakpoint-xxsmall</code>',
					'.text-right-above-xsmall':'Right-align text above <code>$beakpoint-xsmall</code>',
					'.text-right-above-small':'Right-align text above <code>$beakpoint-small</code>',
					'.text-right-above-medium-small':'Right-align text above <code>$beakpoint-medium-small</code>',
					'.text-right-above-medium':'Right-align text above <code>$beakpoint-medium</code>',
					'.text-right-above-medium-large':'Right-align text above <code>$beakpoint-medium-large</code>',
					'.text-right-above-large':'Right-align text above <code>$beakpoint-large</code>',
                    '.text-justify-above-xxsmall':'Justify text above <code>$beakpoint-xxsmall</code>',
					'.text-justify-above-xsmall':'Justify text above <code>$beakpoint-xsmall</code>',
					'.text-justify-above-small':'Justify text above <code>$beakpoint-small</code>',
					'.text-justify-above-medium-small':'Justify text above <code>$beakpoint-medium-small</code>',
					'.text-justify-above-medium':'Justify text above <code>$beakpoint-medium</code>',
					'.text-justify-above-medium-large':'Justify text above <code>$beakpoint-medium-large</code>',
					'.text-justify-above-large':'Justify text above <code>$beakpoint-large</code>'
				},
				uses:[
					'breakpoint-xxsmall',
					'breakpoint-xsmall',
					'breakpoint-small',
					'breakpoint-medium-small',
					'breakpoint-medium',
					'breakpoint-medium-large',
					'breakpoint-large'
				],
				api:'Base/Type'
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
				],
				api:'Base/Type'
			},
			'Base/Visibility': {
				description:'Defines visibility control classes.'
			},
			'Base/Visibility/Hide': {
				description:'Defines a class for hiding content universally',
				defines:{
					'.hide':'Universally hide content'
				},
				api:'Base/Visibility'
			},
			'Base/Visibility/Accessible': {
				description:'Defines visibility control classes for accessibility tools.'
			},
			'Base/Visibility/Accessible/Hide': {
				description:'Defines a class to hide content visually but not for accessibility tools',
				defines:{
					'.hide-accessible':'Hide content except for accessibility tools',
					'.hide-accessible.focusable':'Hide content except for accessibility tools or when focus is applied'
				},
				api:'Base/Visibility'
			},
			'Base/Visibility/Media_Query': {
				description:'Defines visibility control classes for media queries.'
			},
			'Base/Visibility/Media_Query/Hide': {
				description:'Defines a class to hide content when media queries are available.',
				defines:{
					'.hide-media-query':'Hide content if media query support exists'
				},
				api:'Base/Visibility'
			},
			'Base/Visibility/Responsive': {
				description:'Defines a set of classes that allow one to hide content above or below a breakpoint.'
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
				],
				api:'Base/Visibility'
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
				],
				api:'Base/Visibility'
			},
			'Entity': {
				description:'Defines a base set of classes for marking up elements.'
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
				],
				api:'Entity/Badge'
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
				],
				api:'Entity/Blockquote'
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
				requires: [
					'Base/Color'
				],
				supports: [
					'.button.primary',
					'.button.secondary',
					'.button.tertiary',
					'.button.neutral',
					'.button.info',
					'.button.success',
					'.button.warning',
					'.button.danger',
					'.button.important',
					'.button.inverse',
					'.button.required',
					'.button.highlight'
				],
				api:'Entity/Button'
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
				},
				api:'Entity/Button'
			},
			'Entity/Form': {
				description:'Defines a class that can be used to style a form and its controls, as well as an optional class to arrange the form horizontally.',
				defines: {
					'form.form':'Styles a form with labels, controls and text',
					'form.form.horizontal':'Style variation for a two column form with labels on left and controls & text on right that collapses below <code>$breakpoint-small</code>',
					'form.form div.control':'A form control (<code>input</code>, <code>select</code>, <code>textarea</code>) with optional mood color classes and contained label and help text elements',
					'form.form div.control div.inline': 'A set of form controls such as checkboxes or radio buttons that are aligned inline together',
					'form.form .uneditable-input':'Style for an uneditable form control',
					'form.form [input|textarea|select].mini':'Mini size form control',
					'form.form [input|textarea|select].small':'Small size form control',
					'form.form [input|textarea|select].large':'Large size form control',
					'form.form [input|textarea|select].full':'Full width form control'
				},
				uses:[
					'form-horizontal-offset',
					'form-legend-border-color',
					'form-legend-color',
					'form-legend-small-color',
					'form-input-size-mini',
					'form-input-size-small',
					'form-input-size',
					'form-input-size-large',
					'form-input-background-color',
					'form-input-text-color',
					'form-input-border-radius',
					'form-input-border-color',
					'form-input-padding',
					'form-input-uneditable-text-color',
					'form-input-uneditable-background-color',
					'form-input-uneditable-border-color',
					'form-placeholder-text-color'
				],
				supports: [
					'.control.info',
					'.control.success',
					'.control.warning',
					'.control.danger',
					'.control.important',
					'.control.inverse',
					'.control.required',
					'.control.highlight'
				],
				api:'Entity/Form'
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
				},
				api:'Entity/List'
			},
			'Entity/Message': {
				description:'Defines a user interface class that can be used on a block-level element to display it as a message box, optionally with a branding or mood color.',
				defines: {
					'.message':'Styles a block as a message'
				},
				supports: [
					'.message.primary',
					'.message.secondary',
					'.message.tertiary',
					'.message.neutral',
					'.message.info',
					'.message.success',
					'.message.warning',
					'.message.danger',
					'.message.important',
					'.message.inverse',
					'.message.required',
					'.message.highlight'
				],
				requires: [
					'Base/Color'
				],
				api:'Entity/Message'
			},
			'Entity/Nav/Bar': {
				description: 'Defines a user interface class that provides a horizontal navigational menu bar, generally located in the header of the page or the header of some ancillary section.',
				defines: {
					'nav.bar':'Styles a nav element with internal list and optional header as a navbar',
					'nav.bar.top':'Fixes navbar to the top of the screen',
					'nav.bar.bottom':'Fixes navbar to the bottom of the screen',
					'nav.bar .toggle':'Custom toggle when menu is collapsed',
					'nav.bar ul.dropdown':'Custom dropdown for collapsed variant of menu'
				},
				supports: [
					'nav.bar h1.float-right',
					'nav.bar.primary',
					'nav.bar.secondary',
					'nav.bar.tertiary',
					'nav.bar.neutral',
					'nav.bar.info',
					'nav.bar.success',
					'nav.bar.warning',
					'nav.bar.danger',
					'nav.bar.important',
					'nav.bar.inverse',
					'nav.bar.required',
					'nav.bar.highlight'
				],
				requires: [
					'Base/Color',
					'Base/Block/Float'
				],
				api:'Entity/Nav/Bar'
			},
			'Entity/Nav/List': {
				description: 'Defines a user interface class that provides a stacked list of navigation elements, including support for nested lists and headers.',
				defines: {
					'nav.list':'Styles a nav element with an internal set of lists and optional sublists and headers.',
					'nav.list.accordion':'Styles a nav list where child lists are hidden, revealed only when parent link is selected.',
					'nav.list.flyout':'Styles a nav list where child lists appear next to their parent link',
					'nav.list ul.divider':'A list in the nav list with a divider bar before it'
				},
				api:'Entity/Nav/List'
			},
			'Entity/Nav/Breadcrumb': {
			    description: 'Defines a user interface class that provides a breadcrumb-style navigation menu.',
			    defines: {
			        'nav.breadcrumb': 'Styles a nav element with an internal list of links.',
			        'nav.breadcrumb .active': 'An item styled as the "active" or "current" item within the breadcrumb list.',
			        'nav.breadcrumb .divider': 'A divider glyph used to visually demarcate items within the breadcrumb list.'
			    },
			    uses: [
			        'nav-breadcrumb-background-color',
			        'nav-breadcrumb-border-radius',
			        'nav-breadcrumb-item-link-color',
			        'nav-breadcrumb-item-shadow-color',
			        'nav-breadcrumb-active-color',
			        'nav-breadcrumb-divider-color'
			    ],
			    api: 'Entity/Nav/Breadcrumb'
		    },
			'Entity/Table': {
				description:'Defines a user interface class that can be used to style a table, representing tabular data.',
				defines: {
					'table.table':'Styles <code>table</code> element',
					'table.table.hover':'Styles <code>table</code> so that, on hover, row is highlighted',
					'table.table.striped':'Styles <code>table</code> so that rows have alternating background colors (zebra style)',
					'table.table.bordered':'Styles <code>table</code> with a border',
					'table.table.condensed':'Styles <code>table</code> cells to have minimal padding'
				},
				supports: [
					'[table|tr|th|td].primary',
					'[table|tr|th|td].secondary',
					'[table|tr|th|td].tertiary',
					'[table|tr|th|td].neutral',
					'[table|tr|th|td].info',
					'[table|tr|th|td].success',
					'[table|tr|th|td].warning',
					'[table|tr|th|td].danger',
					'[table|tr|th|td].important',
					'[table|tr|th|td].inverse',
					'[table|tr|th|td].required',
					'[table|tr|th|td].highlight'
				],
				uses:[
					'table-caption-text-color',
					'table-border-color',
					'table-cell-padding',
					'table-condensed-cell-padding',
					'table-hover-background-color',
					'table-striped-background-color',
					'table-bordered-border-radius'
				],
				api:'Entity/Table'
			}
		};
		
		
		var arr = [], obj = {}
		for(var name in modules)
			arr.push(name)
		arr = arr.sort();
		for(var i in arr)
			obj[arr[i]] = modules[arr[i]]
		return obj
	}

    DOC.modules.render = function(name){
        var modules = DOC.modules.getAll(),
			view = new EJS({url: 'component/module/basic.ejs'}), 
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
        var modules = DOC.modules.getAll(),
			view = new EJS({url: 'component/module/details.ejs'}), 
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
            data.uses = '$'+uses_variables.join(', $')
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
    
    DOC.modules.get_classes = function(){
        var modules = DOC.modules.getAll(),
			classes = {}, module, class_description
        for(var module_name in modules){
            module = modules[module_name]
            for(var class_name in module.defines){
                class_description = module.defines[class_name]
                classes[class_name] = {
                    description: class_description,
                    module: module_name,
                    module_api: module.api
                }
            }
        }
        return classes
    }
    
    DOC.modules.render_variables = function(name){
		var modules = DOC.modules.getAll()
        if(!modules[name]['uses'])
            return []
        var uses = modules[name]['uses'],
            variables = []
        for(var i in uses)
            variables.push(DOC.vars.sass.render(uses[i]))
        return variables
    }
    
})();