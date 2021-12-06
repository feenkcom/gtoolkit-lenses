Class {
	#name : #LensesInStep,
	#superclass : #Object,
	#traits : 'TLensesStep',
	#classTraits : 'TLensesStep classTrait',
	#instVars : [
		'scopedOutput',
		'fullOutput',
		'previousStep',
		'isScopedOutput',
		'childrenSteps',
		'output',
		'input',
		'lens'
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
		at: self lens name
		ifPresent: [ :aChild | 
			aNewOutput at: self lens name put: aChild copy.
			fullOutput := aNewOutput ]
		ifAbsent: [ 
			self error:
				('Child object named {1} is missing' format: self lens name) ]
]

{ #category : #private }
LensesInStep >> computeScopedOutput [

	self fullOutput
		at: self lens name
		ifPresent: [ :aChild | scopedOutput := LensesScopedJsonObject new object: aChild ]
		ifAbsent: [ 
			self error:
				('Child object named {1} is missing' format: self lens name) ]
]

{ #category : #private }
LensesInStep >> fullOutput [

	fullOutput ifNil: [ self computeFullOutput ].
	^ fullOutput
]

{ #category : #printing }
LensesInStep >> gtDisplayOn: stream [

	self lens ifNil: [ 
		super gtDisplayOn: stream.
		^ self ].

	self lens gtDisplayOn: stream
]

{ #category : #'gt - extensions' }
LensesInStep >> gtHistoryStepChildren [

	^ self children ifNil: [ #(  ) ]
]

{ #category : #'gt - extensions' }
LensesInStep >> gtHistoryStepItemDisplayText [

	self lens ifNil: [ ^ self gtDisplayString ].

	^ self lens gtHistoryStepItemDisplayText
]

{ #category : #initialization }
LensesInStep >> initialize [

	super initialize.

	isScopedOutput := true
]

{ #category : #'api - steps' }
LensesInStep >> input [

	^ input ifNil: [ input := self previousStep input ]
]

{ #category : #'api - steps' }
LensesInStep >> input: anInput [

	input := anInput
]

{ #category : #private }
LensesInStep >> isScopedOutput [

	^ isScopedOutput
]

{ #category : #accessing }
LensesInStep >> lens [

	^ lens
]

{ #category : #accessing }
LensesInStep >> lens: anObject [

	lens := anObject
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
		at: self lens name
		ifPresent: [ :aChild | 
			| aLastStep |
			aLastStep := self children last.
			self fullOutput at: self lens name put: aLastStep output object ]
		ifAbsent: [ 
			self error:
				('Child object named {1} is missing' format: self lens name) ]
]

{ #category : #'api - steps' }
LensesInStep >> withPreviousStepsDo: aBlock [

	self previousStep withPreviousStepsDo: aBlock.
	aBlock cull: self
]
