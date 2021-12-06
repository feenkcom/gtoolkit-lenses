Class {
	#name : #LensesTransformationStep,
	#superclass : #Object,
	#traits : 'TLensesStep',
	#classTraits : 'TLensesStep classTrait',
	#instVars : [
		'property',
		'output',
		'previousStep',
		'input'
	],
	#category : #'GToolkit-Lenses-Steps'
}

{ #category : #stack }
LensesTransformationStep >> forProperty: aProperty [

	^ LensesTransformationStep new
		  parentStep: self;
		  property: aProperty;
		  input: self output;
		  output: self output asOutput
]

{ #category : #printing }
LensesTransformationStep >> gtDisplayOn: stream [

	self property ifNil: [ 
		super gtDisplayOn: stream.
		^ self ].

	self property gtDisplayOn: stream
]

{ #category : #'gt - extensions' }
LensesTransformationStep >> gtHistoryStepItemDisplayText [

	self property ifNil: [ ^ self gtDisplayString ].

	^ self property gtHistoryStepItemDisplayText
]

{ #category : #'api - steps' }
LensesTransformationStep >> input [

	^ input ifNil: [ input := self previousStep output ]
]

{ #category : #accessing }
LensesTransformationStep >> input: anObject [

	input := anObject
]

{ #category : #'api - steps' }
LensesTransformationStep >> output [

	^ output ifNil: [ output := self previousStep followingOutput ]
]

{ #category : #accessing }
LensesTransformationStep >> output: anObject [

	output := anObject
]

{ #category : #accessing }
LensesTransformationStep >> previousStep [

	^ previousStep
]

{ #category : #accessing }
LensesTransformationStep >> previousStep: anObject [

	previousStep := anObject
]

{ #category : #accessing }
LensesTransformationStep >> property [

	^ property
]

{ #category : #accessing }
LensesTransformationStep >> property: anObject [

	property := anObject
]

{ #category : #'api - steps' }
LensesTransformationStep >> withPreviousStepsDo: aBlock [

	self previousStep withPreviousStepsDo: aBlock.
	aBlock cull: self
]
