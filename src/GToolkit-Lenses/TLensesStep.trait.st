Trait {
	#name : #TLensesStep,
	#category : #'GToolkit-Lenses-Executors'
}

{ #category : #'gt - extensions' }
TLensesStep >> gtHistoryFor: aView [

	<gtView>
	^ aView columnedList
		  title: 'Changes';
		  priority: 5;
		  items: [ self withParents ];
		  column: 'Name' text: #yourself
]

{ #category : #'gt - extensions' }
TLensesStep >> gtInputFor: aView [

	<gtView>
	self input ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Input';
		  priority: 1;
		  object: [ self input ];
		  view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
TLensesStep >> gtOutputFor: aView [

	<gtView>
	self input ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Output';
		  priority: 2;
		  object: [ self output ];
		  view: #gtLiveFor:
]

{ #category : #enumerating }
TLensesStep >> initialInput [

	self withParentsDo: [ :aParent | ^ aParent input ].
]

{ #category : #accessing }
TLensesStep >> input [

	^ self explicitRequirement
]

{ #category : #accessing }
TLensesStep >> output [

	^ self explicitRequirement
]

{ #category : #enumerating }
TLensesStep >> withParents [

	^ Array new: self withParentsCount streamContents: [ :aStream | 
		  self withParentsDo: [ :aParent | aStream nextPut: aParent ] ]
]

{ #category : #enumerating }
TLensesStep >> withParentsCount [

	| aCount |
	aCount := 0.
	self withParentsDo: [ aCount := aCount + 1 ].
	^ aCount
]

{ #category : #enumerating }
TLensesStep >> withParentsDo: aBlock [

	self explicitRequirement
]
