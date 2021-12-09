Trait {
	#name : #TLensesStep,
	#category : #'GToolkit-Lenses-Model-Steps'
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
