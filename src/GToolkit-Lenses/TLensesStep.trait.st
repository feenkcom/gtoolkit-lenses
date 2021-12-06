Trait {
	#name : #TLensesStep,
	#category : #'GToolkit-Lenses-Steps'
}

{ #category : #'api - steps' }
TLensesStep >> at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [

	self output at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #'api - steps' }
TLensesStep >> at: aKey put: aValue [

	self output at: aKey put: aValue
]

{ #category : #'api - steps' }
TLensesStep >> followingOutput [

	^ self output asFollowingOutput
]

{ #category : #'gt - extensions' }
TLensesStep >> gtHistoryFor: aView [

	<gtView>
	^ aView columnedList
		  title: 'Changes';
		  priority: 5;
		  items: [ self withPreviousSteps ];
		  column: 'Name' text: #yourself
]

{ #category : #'gt - extensions' }
TLensesStep >> gtHistoryStepChildren [

	^ #(  )
]

{ #category : #'gt - extensions' }
TLensesStep >> gtHistoryStepItemDisplayText [

	^ self gtDisplayText
]

{ #category : #accessing }
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
		  title: 'Input';
		  priority: 1;
		  object: [ self input ];
		  view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
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
		  title: 'Output';
		  priority: 2;
		  object: [ self output ];
		  view: #gtLiveFor:
]

{ #category : #'api - steps' }
TLensesStep >> initialInput [

	self withPreviousStepsDo: [ :aParent | ^ aParent input ].
]

{ #category : #'api - steps' }
TLensesStep >> input [

	^ self explicitRequirement
]

{ #category : #'api - steps' }
TLensesStep >> output [

	^ self explicitRequirement
]

{ #category : #'api - steps' }
TLensesStep >> removeKey: aKey [

	self output removeKey: aKey
]

{ #category : #'api - steps' }
TLensesStep >> withPreviousSteps [

	^ Array new: self withPreviousStepsCount streamContents: [ :aStream | 
		  self withPreviousStepsDo: [ :aParent | aStream nextPut: aParent ] ]
]

{ #category : #'api - steps' }
TLensesStep >> withPreviousStepsCount [

	| aCount |
	aCount := 0.
	self withPreviousStepsDo: [ aCount := aCount + 1 ].
	^ aCount
]

{ #category : #'api - steps' }
TLensesStep >> withPreviousStepsDo: aBlock [

	self explicitRequirement
]
