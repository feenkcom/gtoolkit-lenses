Extension { #name : #TLensesStep }

{ #category : #'*GToolkit-Lenses-Widgets' }
TLensesStep >> gtHistoryFor: aView [

	<gtView>
	^ aView columnedList
		  title: 'Changes';
		  priority: 5;
		  items: [ self withPreviousSteps ];
		  column: 'Name' text: #yourself
]

{ #category : #'*GToolkit-Lenses-Widgets' }
TLensesStep >> gtHistoryStepChildren [

	^ #(  )
]

{ #category : #'*GToolkit-Lenses-Widgets' }
TLensesStep >> gtHistoryStepItemDisplayText [

	^ self gtDisplayText
]

{ #category : #'*GToolkit-Lenses-Widgets' }
TLensesStep >> gtInputFor: aView context: aContext [

	<gtView>
	self input ifNil: [ ^ aView empty ].

	aContext at: #gtTreeIndexStyler ifAbsentPut: [ 
		[ :aNode | 
		| aText |
		aText := aNode key gtDisplayText asRopedText.

		aNode hasParent ifFalse: [ 
			self output
				at: aNode key
				ifPresent: [ :aValue | aText foreground: Color gray ]
				ifAbsent: [ 
				aText foreground: BrGlamorousColors errorBackgroundColor ].
			aText ].
		aText ] ].

	^ aView forward
		  title: 'Input (Object)';
		  priority: 1;
		  object: [ self input ];
		  view: #gtLiveFor:
]

{ #category : #'*GToolkit-Lenses-Widgets' }
TLensesStep >> gtInputTextFor: aView context: aContext [

	<gtView>
	self input ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Input (Text)';
		  priority: 1;
		  object: [ self input ];
		  view: #gtTextFor:
]

{ #category : #'*GToolkit-Lenses-Widgets' }
TLensesStep >> gtOutputFor: aView context: aContext [

	<gtView>
	self input ifNil: [ ^ aView empty ].

	aContext at: #gtTreeIndexStyler ifAbsentPut: [ 
		[ :aNode | 
		| aText |
		aText := aNode key gtDisplayText asRopedText.

		aNode hasParent ifFalse: [ 
			self input
				at: aNode key
				ifPresent: [ :aValue | aText foreground: Color gray ]
				ifAbsent: [ 
				aText foreground: BrGlamorousColors successBackgroundColor ] ].
		aText ] ].

	^ aView forward
		  title: 'Output (Object)';
		  priority: 2;
		  object: [ self output ];
		  view: #gtLiveFor:
]

{ #category : #'*GToolkit-Lenses-Widgets' }
TLensesStep >> gtOutputTextFor: aView context: aContext [

	<gtView>
	self input ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Output (Text)';
		  priority: 2;
		  object: [ self output ];
		  view: #gtTextFor:
]
