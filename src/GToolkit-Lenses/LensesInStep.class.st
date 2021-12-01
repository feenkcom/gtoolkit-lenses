Class {
	#name : #LensesInStep,
	#superclass : #Object,
	#traits : 'TLensesStep',
	#classTraits : 'TLensesStep classTrait',
	#instVars : [
		'property',
		'scopedOutput',
		'fullOutput',
		'previousStep',
		'isScopedOutput',
		'childrenSteps',
		'output'
	],
	#category : #'GToolkit-Lenses-Steps'
}

{ #category : #'api - steps' }
LensesInStep >> at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [

	self output
		at: self property name
		ifPresent: [ :aChild | 
			aChild at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock ]
		ifAbsent: [ 
			self error:
				('Child object named {1} is missing' format: self property name) ]
]

{ #category : #'api - steps' }
LensesInStep >> at: aKey put: aValue [

	self output
		at: self property name
		ifPresent: [ :aChild | aChild at: aKey put: aValue ]
		ifAbsent: [ 
			self error:
				('Child object named {1} is missing' format: self property name) ]
]

{ #category : #'api - steps' }
LensesInStep >> beFullOutput [

	isScopedOutput := false.
	self updateFullOutput.
]

{ #category : #'api - steps' }
LensesInStep >> beScopedOutput [

	isScopedOutput := true
]

{ #category : #accessing }
LensesInStep >> children [

	^ childrenSteps
]

{ #category : #accessing }
LensesInStep >> children: aCollection [

	childrenSteps := aCollection
]

{ #category : #private }
LensesInStep >> computeFullOutput [

	| aNewOutput |
	aNewOutput := self previousStep followingOutput.
	aNewOutput
		at: self property name
		ifPresent: [ :aChild | 
			aNewOutput at: self property name put: aChild copy.
			fullOutput := aNewOutput ]
		ifAbsent: [ 
			self error:
				('Child object named {1} is missing' format: self property name) ]
]

{ #category : #private }
LensesInStep >> computeScopedOutput [

	self fullOutput
		at: self property name
		ifPresent: [ :aChild | scopedOutput := LensesScopedJsonObject new object: aChild ]
		ifAbsent: [ 
			self error:
				('Child object named {1} is missing' format: self property name) ]
]

{ #category : #private }
LensesInStep >> fullOutput [

	fullOutput ifNil: [ self computeFullOutput ].
	^ fullOutput
]

{ #category : #printing }
LensesInStep >> gtDisplayOn: stream [

	self property ifNil: [ 
		super gtDisplayOn: stream.
		^ self ].

	self property gtDisplayOn: stream
]

{ #category : #'gt - extensions' }
LensesInStep >> gtHistoryStepChildren [

	^ self children ifNil: [ #(  ) ]
]

{ #category : #initialization }
LensesInStep >> initialize [

	super initialize.

	isScopedOutput := true
]

{ #category : #'api - steps' }
LensesInStep >> input [

	^ self previousStep input
]

{ #category : #private }
LensesInStep >> isScopedOutput [

	^ isScopedOutput
]

{ #category : #'api - steps' }
LensesInStep >> output [

	^ self isScopedOutput
		  ifTrue: [ self scopedOutput ]
		  ifFalse: [ self fullOutput ]
]

{ #category : #accessing }
LensesInStep >> previousStep [

	^ previousStep
]

{ #category : #accessing }
LensesInStep >> previousStep: anObject [

	previousStep := anObject
]

{ #category : #accessing }
LensesInStep >> property [

	^ property
]

{ #category : #accessing }
LensesInStep >> property: anObject [

	property := anObject
]

{ #category : #'api - steps' }
LensesInStep >> removeKey: aKey [

	self output
		at: self property name
		ifPresent: [ :aChild | aChild removeKey: aKey ]
		ifAbsent: [ 
			self error:
				('Child object named {1} is missing' format: self property name) ]
]

{ #category : #private }
LensesInStep >> scopedOutput [

	scopedOutput ifNil: [ self computeScopedOutput ].
	^ scopedOutput
]

{ #category : #private }
LensesInStep >> updateFullOutput [

	self children ifNil: [ ^ self ].
	self children ifEmpty: [ ^ self ].

	self fullOutput
		at: self property name
		ifPresent: [ :aChild | 
			| aLastStep |
			aLastStep := self children last.
			self fullOutput at: self property name put: aLastStep output object ]
		ifAbsent: [ 
			self error:
				('Child object named {1} is missing' format: self property name) ]
]

{ #category : #'api - steps' }
LensesInStep >> withPreviousStepsDo: aBlock [

	self previousStep withPreviousStepsDo: aBlock.
	aBlock cull: self
]
