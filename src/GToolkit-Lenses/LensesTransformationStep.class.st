Class {
	#name : #LensesTransformationStep,
	#superclass : #Object,
	#traits : 'TLensesStep',
	#classTraits : 'TLensesStep classTrait',
	#instVars : [
		'output',
		'previousStep',
		'input',
		'lens'
	],
	#category : #'GToolkit-Lenses-Steps'
}

{ #category : #printing }
LensesTransformationStep >> gtDisplayOn: stream [

	self lens ifNil: [ 
		super gtDisplayOn: stream.
		^ self ].

	self lens gtDisplayOn: stream
]

{ #category : #'gt - extensions' }
LensesTransformationStep >> gtHistoryStepItemDisplayText [

	self lens ifNil: [ ^ self gtDisplayString ].

	^ self lens gtHistoryStepItemDisplayText
]

{ #category : #'api - steps' }
LensesTransformationStep >> input [

	^ input ifNil: [ input := self previousStep output ]
]

{ #category : #accessing }
LensesTransformationStep >> input: anObject [

	input := anObject
]

{ #category : #accessing }
LensesTransformationStep >> lens [

	^ lens
]

{ #category : #accessing }
LensesTransformationStep >> lens: aLens [

	lens := aLens
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

{ #category : #'api - steps' }
LensesTransformationStep >> withPreviousStepsDo: aBlock [

	self previousStep withPreviousStepsDo: aBlock.
	aBlock cull: self
]
