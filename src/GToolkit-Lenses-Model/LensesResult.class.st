Class {
	#name : #LensesResult,
	#superclass : #Object,
	#traits : 'TLensesStep',
	#classTraits : 'TLensesStep classTrait',
	#instVars : [
		'parentStep'
	],
	#category : #'GToolkit-Lenses-Model-Steps'
}

{ #category : #printing }
LensesResult >> gtDisplayOn: stream [

	stream nextPutAll: 'Result'
]

{ #category : #'api - steps' }
LensesResult >> input [

	^ self initialInput
]

{ #category : #'api - steps' }
LensesResult >> output [

	^ self parentStep output
]

{ #category : #accessing }
LensesResult >> parentStep [

	^ parentStep
]

{ #category : #accessing }
LensesResult >> parentStep: anObject [

	parentStep := anObject
]

{ #category : #'api - steps' }
LensesResult >> withPreviousStepsDo: aBlock [

	self parentStep withPreviousStepsDo: aBlock.
	aBlock cull: self
]
