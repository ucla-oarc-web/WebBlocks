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
				api:'Base/Block'
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
                api:'Base/Block'
            },
            'Base/Block/Overflow': {
                description:'Defines a set of classes that assist with handling when inner contents overflow a container.',
                defines: {
                    '.overflow-scroll':'If inner content exceeds container bounds, allow scrolling of inner content.'
                },
                api:'Base/Block'
            },
			'Base/Color': {
				description:'Defines a set of brand-related and mood-related colors for text and backgrounds'
			},
			'Base/Color/Body': {
				description:'Defines body background and text colors',
				uses:[
					'color-body-background',
					'color-body-background-text',
					'color-body-link-text',
					'color-body-link-hover-text'
				]
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
				supports: [
					'.primary a',
					'.secondary a',
					'.tertiary a',
					'.neutral a'
				],
                uses: [
                    'color-branding-[BRAND]',
                    'color-branding-[BRAND]-background-text',
                    'color-branding-[BRAND]-background-shadow',
                    'color-branding-[BRAND]-border',
                    'color-branding-[BRAND]-background-text-shadow',
                    'color-grade-dk',
                    'color-grade-lt',
                    'color-grade-dk-text',
                    'color-grade-lt-text',
                    'color-contrast-threshold'
                ],
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
                uses: [
                    'color-branding-[BRAND]',
                    'color-branding-[BRAND]-background',
                    'color-branding-[BRAND]-background-shadow',
                    'color-grade-lt'
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
				supports: [
					'.primary.light a',
					'.secondary.light a',
					'.tertiary.light a',
					'.neutral.light a'
				],
                uses: [
                    'color-branding-[BRAND]',
                    'color-branding-[BRAND]-background-light-text',
                    'color-branding-[BRAND]-background-light-shadow',
                    'color-branding-[BRAND]-light-border',
                    'color-branding-[BRAND]-background-light-text-shadow',
                    'color-grade-dk',
                    'color-grade-lt',
                    'color-grade-dk-text',
                    'color-grade-lt-text',
                    'color-contrast-threshold',
                    'color-background-light-brightness',
                    'color-background-shadow-light-brightness',
                    'color-light-border-brightness',
                    'color-contrast-threshold-light'
                ],
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
                uses: [
                    'color-branding-[BRAND]',
                    'color-branding-[BRAND]-background-light',
                    'color-branding-[BRAND]-background-light-shadow',
                    'color-branding-[BRAND]-background-light-text',
                    'color-branding-[BRAND]-background-light-text-shadow',
                    'color-grade-lt'
                ],
				api:'Base/Color'
			},
			'Base/Color/Branding/Background_Dark': {
				description:'Defines a set of dark color classes that may be used for brand-related background colors.',
				defines:{
					'.primary.dark':'Dark primary brand background color',
					'.secondary.dark':'Dark secondary brand background color',
					'.tertiary.dark':'Dark tertiary brand background color',
					'.neutral.dark':'Dark neutral brand background color'
				},
				supports: [
					'.primary.dark a',
					'.secondary.dark a',
					'.tertiary.dark a',
					'.neutral.dark a'
				],
                uses: [
                    'color-branding-[BRAND]',
                    'color-branding-[BRAND]-background-dark-text',
                    'color-branding-[BRAND]-background-dark-shadow',
                    'color-branding-[BRAND]-dark-border',
                    'color-branding-[BRAND]-background-dark-text-shadow',
                    'color-grade-dk',
                    'color-grade-lt',
                    'color-grade-dk-text',
                    'color-grade-lt-text',
                    'color-contrast-threshold',
                    'color-background-dark-brightness',
                    'color-background-shadow-dark-brightness',
                    'color-dark-border-brightness',
                    'color-contrast-threshold-dark'
                ],
				api:'Base/Color'
			},
			'Base/Color/Branding/Background_Dark_Gradient': {
				description:'Defines a set of dark gradient color classes that may be used for brand-related background colors.',
				defines:{
					'.primary.dark.gradient':'Dark primary gradient brand background color',
					'.secondary.dark.gradient':'Dark secondary gradient brand background color',
					'.tertiary.dark.gradient':'Dark tertiary gradient brand background color',
					'.neutral.dark.gradient':'Dark neutral gradient brand background color'
				},
				requires: [
					'Base/Color/Branding/Background_Dark'
				],
                uses: [
                    'color-branding-[BRAND]',
                    'color-branding-[BRAND]-background-dark',
                    'color-branding-[BRAND]-background-dark-shadow',
                    'color-branding-[BRAND]-background-dark-text',
                    'color-branding-[BRAND]-background-dark-text-shadow',
                    'color-grade-lt'
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
                uses: [
                    'color-branding-[BRAND]',
                    'color-branding-[BRAND]-text-brightness',
                    'color-branding-[BRAND]-foreground-text',
                    'color-text-brightness'
                ],
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
				supports: [
					'.info a',
					'.success a',
					'.warning a',
					'.error a',
					'.danger a',
					'.important a',
					'.inverse a',
					'.required a',
                    '.highlight a'
				],
                uses: [
                    'color-grade-dk',
                    'color-grade-lt',
                    'color-grade-dk-text',
                    'color-grade-lt-text',
                    'color-contrast-threshold',
                    'color-mood-[MOOD]',
                    'color-mood-[MOOD]-background-text',
                    'color-mood-[MOOD]-background-shadow',
                    'color-mood-[MOOD]-border',
                    'color-mood-[MOOD]-background-text-shadow'
                ],
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
                uses: [
                    'color-grade-lt',
                    'color-mood-[MOOD]',
                    'color-mood-[MOOD]-background',
                    'color-mood-[MOOD]-background-shadow'
                ],
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
				supports: [
					'.info.light a',
					'.success.light a',
					'.warning.light a',
					'.error.light a',
					'.danger.light a',
					'.important.light a',
					'.inverse.light a',
					'.required.light a',
                    '.highlight.light a'
				],
                uses: [
                    'color-grade-dk',
                    'color-grade-lt',
                    'color-grade-dk-text',
                    'color-grade-lt-text',
                    'color-contrast-threshold',
                    'color-background-light-brightness',
                    'color-background-shadow-light-brightness',
                    'color-light-border-brightness',
                    'color-contrast-threshold-light',
                    'color-mood-[MOOD]',
                    'color-mood-[MOOD]-background-light-text',
                    'color-mood-[MOOD]-background-light-shadow',
                    'color-mood-[MOOD]-light-border',
                    'color-mood-[MOOD]-background-light-text-shadow'
                ],
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
                uses: [
                    'color-grade-lt',
                    'color-mood-[MOOD]',
                    'color-mood-[MOOD]-background-light',
                    'color-mood-[MOOD]-background-light-shadow',
                    'color-mood-[MOOD]-background-light-text',
                    'color-mood-[MOOD]-background-light-text-shadow',
                ],
				api:'Base/Color'
			},
			'Base/Color/Mood/Background_Dark': {
				description:'Defines a set of dark color classes that may be used for mood-related background colors.',
				defines:{
					'.info.dark':'Dark info mood background color',
					'.success.dark':'Dark success mood background color',
					'.warning.dark':'Dark warning mood background color',
					'.error.dark':'Dark error mood background color',
					'.danger.dark':'Dark danger mood background color',
					'.important.dark':'Dark important mood background color',
					'.inverse.dark':'Dark inverse mood background color',
					'.required.dark':'Dark required mood background color',
					'.highdark.dark':'Dark highdark mood background color'
				},
				supports: [
					'.info.dark a',
					'.success.dark a',
					'.warning.dark a',
					'.error.dark a',
					'.danger.dark a',
					'.important.dark a',
					'.inverse.dark a',
					'.required.dark a',
                    '.highlight.dark a'
				],
                uses: [
                    'color-grade-dk',
                    'color-grade-lt',
                    'color-grade-dk-text',
                    'color-grade-lt-text',
                    'color-contrast-threshold',
                    'color-background-dark-brightness',
                    'color-background-shadow-dark-brightness',
                    'color-dark-border-brightness',
                    'color-contrast-threshold-dark',
                    'color-mood-[MOOD]',
                    'color-mood-[MOOD]-background-dark-text',
                    'color-mood-[MOOD]-background-dark-shadow',
                    'color-mood-[MOOD]-dark-border',
                    'color-mood-[MOOD]-background-dark-text-shadow'
                ],
				api:'Base/Color'
			},
			'Base/Color/Mood/Background_Dark_Gradient': {
				description:'Defines a set of dark gradient color classes that may be used for mood-related background colors.',
				defines:{
					'.info.dark.gradient':'Dark info gradient mood background color',
					'.success.dark.gradient':'Dark success gradient mood background color',
					'.warning.dark.gradient':'Dark warning gradient mood background color',
					'.error.dark.gradient':'Dark error gradient mood background color',
					'.danger.dark.gradient':'Dark danger gradient mood background color',
					'.important.dark.gradient':'Dark important gradient mood background color',
					'.inverse.dark.gradient':'Dark inverse gradient mood background color',
					'.required.dark.gradient':'Dark required gradient mood background color',
					'.highdark.dark.gradient':'Dark highdark gradient mood background color'
				},
				requires: [
					'Base/Color/Mood/Background_Dark'
				],
                uses: [
                    'color-grade-lt',
                    'color-mood-[MOOD]',
                    'color-mood-[MOOD]-background-dark',
                    'color-mood-[MOOD]-background-dark-shadow',
                    'color-mood-[MOOD]-background-dark-text',
                    'color-mood-[MOOD]-background-dark-text-shadow'
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
                uses: [
                    'color-branding-[BRAND]',
                    'color-branding-[BRAND]-text-brightness',
                    'color-branding-[BRAND]-foreground-text',
                    'color-text-brightness'
                ],
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
            'Base/Structure/Cluster': {
                description:'Defines a class whereby all direct children (up to six) become equal-width columns that collapse responsively',
                defines:{
                    '.cluster':'Parent of clustered elements',
                    '.cluster.left':'Parent of clustered elements, where uneven collapsed rows will align left',
                    '.cluster > *':'Clustered elements treated as equal-width columns (up to six allowed)'
                },
                uses:[
                    'structure-cluster-element-gutter',
                    'structure-cluster-breakpoint-2-columns',
                    'structure-cluster-breakpoint-3-columns',
                    'structure-cluster-breakpoint-4-columns',
                    'structure-cluster-breakpoint-6-columns'
                ],
                api:'Base/Structure/Cluster'
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
			'Compatibility': {
				description:'Defines a set of compatibility features.'
			},
			'Compatibility/IE': {
				description:'Defines a set of IE compatibility features.'
			},
			'Compatibility/IE/Image': {
				description:'Defines a set of IE compatibility features for images.'
			},
			'Compatibility/IE/Image/Scaling': {
				description:'Adds bicubic scaling on JPEG images for IE 7 and below.',
				api:'Compatibility'
			},
            'Compatibility/IE/CSS': {
				description:'Defines a set of compatibility features for CSS effects.'
            },
            'Compatibility/IE/CSS/Filter': {
				description:'Defines a set of compatibility features for CSS filter effect.'
            },
            'Compatibility/IE/CSS/Filter/Border_Radius': {
                description:'Defines a method for transparently bypassing the fact that the filter property overrides border-radius.',
				api:'Compatibility',
                definesJS: {
					'Blocks.IE.css.filter.borderRadius()':'Generates a wrapper element inside of the targetted element and moves the filter to it to avoid overriding border-radius.'
                }
            },
			'Compatibility/Support': {
				description:'Defines a set of methods (and properties on Modernizr) for detecting whether or not WebBlocks features are supported by the browser.',
				api:'Compatibility',
                definesJS: {
					'Blocks.support.required()':'Browser supports all features required for WebBlocks',
					'Blocks.support.full()':'Browser supports all features recommended for WebBlocks',
                }
			},
			'Compatibility/Support/CSS': {
				description:'Defines a set of properties on the Modernizr object for detecting whether or not the browser supports CSS features used by WebBlocks.',
				api:'Compatibility',
                definesJS: {
					'Modernizr.blocks_css_required':'Browser supports all CSS features required for WebBlocks',
					'Modernizr.blocks_css_full':'Browser supports all CSS features recommended for WebBlocks',
                }
			},
			'Compatibility/Support/HTML': {
				description:'Defines a set of properties on the Modernizr object for detecting whether or not the browser supports HTML features used by WebBlocks.',
				api:'Compatibility',
                definesJS: {
					'Modernizr.blocks_html_required':'Browser supports all HTML APIs required for WebBlocks',
					'Modernizr.blocks_html_full':'Browser supports all HTML APIs recommended for WebBlocks',
                }
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
                uses: [
                    'blockquote-small-color',
                    'blockquote-border-color'
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
				uses:[
					'button-border-radius-multiplier',
					'button-border-radius-multiplier-default',
					'button-border-radius-multiplier-large',
					'button-border-radius-multiplier-mini',
					'button-border-radius-multiplier-small',
                    'button-cursor',
                    'button-font-size-default',
                    'button-font-size-large',
                    'button-font-size-mini',
                    'button-font-size-small',
                    'button-padding-multiplier-default-horizontal',
                    'button-padding-multiplier-default-vertical',
                    'button-padding-multiplier-horizontal',
                    'button-padding-multiplier-large-horizontal',
                    'button-padding-multiplier-large-vertical',
                    'button-padding-multiplier-mini-horizontal',
                    'button-padding-multiplier-mini-vertical',
                    'button-padding-multiplier-small-horizontal',
                    'button-padding-multiplier-small-vertical',
                    'button-padding-multiplier-vertical',
                    'button-boxshadow-hover'
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
                    'form-input-font-size',
                    'form-legend-font-size',
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
                    'form-input-boxshadow',
                    'form-input-boxshadow-focus',
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
                uses: [
                    'message-border-radius',
                    'message-header-color-brightness-difference-light',
                    'message-header-color-brightness-difference-dark'
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
            'Entity/Nav/Tabs': {
                description: 'Defines a user interface class that provides a tabs-style navigation menu.',
                defines: {
                    'nav.tabs': 'Styles a nav element as a list of tabs.',
                    'nav.tabs li a.active': 'An item styled as the "active" item within the tabs list.',
                    'nav.tabs li a:hover': 'An item styled as hovered over within the tabs list.'
                },
                uses: [
                    'nav-tabs-border-bottom-color',
                    'nav-tabs-link-padding-X',
                    'nav-tabs-link-padding-Y',
                    'nav-tabs-link-spacing-before',
                    'nav-tabs-link-spacing-after',
                    'nav-tabs-link-border-color',
                    'nav-tabs-link-background-color',
                    'nav-tabs-link-border-radius',
                    'nav-tabs-link-active-border-color',
                    'nav-tabs-link-active-background-color',
                    'nav-tabs-link-hover-border-color',
                    'nav-tabs-link-hover-background-color'
                ],
                api: 'Entity/Nav/Tabs'
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
			},
            'Extend': {
                description:'Defines a set of modules that add functionality that is not part of WebBlocks core. Some of these may be useful in niche contexts, while others may eventually make it into the core namespaces, although possibly with semantic changes.'
            },
            'Extend/Base': {
                description:'Defines a set of modules that are not part of WebBlocks core but add additional foundational structures and functionality.'
            },
            'Extend/Base/Color': {
                definition:'Extends the <code>Base/Color</code> namespace with additional non-core functionality.'
            },
            'Extend/Base/Color/Branding': {
                definition:'Extends the <code>Base/Color/Branding</code> namespace with additional non-core functionality for branding colors.'
            },
            'Extend/Base/Color/Mood': {
                definition:'Extends the <code>Base/Color/Mood</code> namespace with additional non-core functionality for mood colors.'
            },
			'Extend/Base/Color/Branding/Background_Fade': {
				description:'Defines a set of color classes that may be used for brand-related background colors and have the property that they are conditionally light if the background is light or dark if the background is dark.',
				defines:{
					'.primary.fade':'Primary brand background color faded against body background',
					'.secondary.fade':'Secondary brand background color faded against body background',
					'.tertiary.fade':'Tertiary brand background color faded against body background',
					'.neutral.fade':'Neutral brand background color faded against body background',
					'.default.fade':'Default brand background color faded against body background'
				},
				requires: [
					'Base/Color/Branding/Background_Light',
					'Base/Color/Branding/Background_Light_Gradient',
					'Base/Color/Branding/Background_Dark',
					'Base/Color/Branding/Background_Dark_Gradient',
				],
                uses: [
                    'color-body-light'
                ],
				api:'Base/Color'
			},
			'Extend/Base/Color/Mood/Background_Fade': {
				description:'Defines a set of color classes that may be used for mood-related background colors and have the property that they are conditionally light if the background is light or dark if the background is dark.',
				defines:{
					'.info.fade':'Info mood background color faded against body background',
					'.success.fade':'Success mood background color faded against body background',
					'.warning.fade':'Warning mood background color faded against body background',
					'.error.fade':'Error mood background color faded against body background',
					'.danger.fade':'Danger mood background color faded against body background',
					'.important.fade':'Important mood background color faded against body background',
					'.inverse.fade':'Inverse mood background color faded against body background',
					'.required.fade':'Required mood background color faded against body background',
					'.highlight.fade':'Highlight mood background color faded against body background'
				},
				requires: [
					'Base/Color/Mood/Background_Light',
					'Base/Color/Mood/Background_Light_Gradient',
					'Base/Color/Mood/Background_Dark',
					'Base/Color/Mood/Background_Dark_Gradient',
				],
                uses: [
                    'color-body-light'
                ],
				api:'Base/Color'
			},
			'Extend/Base/Color/Branding/Background_Emphasize': {
				description:'Defines a set of color classes that may be used for brand-related background colors and have the property that they are conditionally dark if the background is light or light if the background is dark.',
				defines:{
					'.primary.emphasize':'Primary brand background color emphasized against body background',
					'.secondary.emphasize':'Secondary brand background color emphasized against body background',
					'.tertiary.emphasize':'Tertiary brand background color emphasized against body background',
					'.neutral.emphasize':'Neutral brand background color emphasized against body background',
					'.default.emphasize':'Default brand background color emphasized against body background'
				},
				requires: [
					'Base/Color/Branding/Background_Light',
					'Base/Color/Branding/Background_Light_Gradient',
					'Base/Color/Branding/Background_Dark',
					'Base/Color/Branding/Background_Dark_Gradient',
				],
                uses: [
                    'color-body-light'
                ],
				api:'Base/Color'
			},
			'Extend/Base/Color/Mood/Background_Emphasize': {
				description:'Defines a set of color classes that may be used for mood-related background colors and have the property that they are conditionally dark if the background is light or light if the background is dark.',
				defines:{
					'.info.emphasize':'Info mood background color emphasized against body background',
					'.success.emphasize':'Success mood background color emphasized against body background',
					'.warning.emphasize':'Warning mood background color emphasized against body background',
					'.error.emphasize':'Error mood background color emphasized against body background',
					'.danger.emphasize':'Danger mood background color emphasized against body background',
					'.important.emphasize':'Important mood background color emphasized against body background',
					'.inverse.emphasize':'Inverse mood background color emphasized against body background',
					'.required.emphasize':'Required mood background color emphasized against body background',
					'.highlight.emphasize':'Highlight mood background color emphasized against body background'
				},
				requires: [
					'Base/Color/Mood/Background_Light',
					'Base/Color/Mood/Background_Light_Gradient',
					'Base/Color/Mood/Background_Dark',
					'Base/Color/Mood/Background_Dark_Gradient',
				],
                uses: [
                    'color-body-light'
                ],
				api:'Base/Color'
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
        if(data.definesJS){
            var definitions_js = []
            for(var i in data.definesJS)
                definitions_js.push(i)
            data.definitions_js = definitions_js.join(', ')
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
        if(data.definesJS){
            var definitions_js = []
            for(var i in data.definesJS)
                definitions_js.push(i)
            data.definitions_js = definitions_js.join(', ')
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