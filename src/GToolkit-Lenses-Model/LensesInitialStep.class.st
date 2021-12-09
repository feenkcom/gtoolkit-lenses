Class {
	#name : #LensesInitialStep,
	#superclass : #Object,
	#traits : 'TLensesStep',
	#classTraits : 'TLensesStep classTrait',
	#instVars : [
		'input'
	],
	#category : #'GToolkit-Lenses-Model-Steps'
}

{ #category : #printing }
LensesInitialStep >> gtDisplayOn: stream [

	stream nextPutAll: 'Initial input'
]

{ #category : #'api - steps' }
LensesInitialStep >> initialInput [

	^ self input
]

{ #category : #'api - steps' }
LensesInitialStep >> input [

	^ input
]

{ #category : #accessing }
LensesInitialStep >> input: anObject [

	input := anObject
]

{ #category : #'api - steps' }
LensesInitialStep >> output [

	^ self input
]

{ #category : #'api - steps' }
LensesInitialStep >> withPreviousStepsDo: aBlock [

	aBlock cull: self
]
