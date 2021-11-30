Class {
	#name : #LensesResult,
	#superclass : #Object,
	#traits : 'TLensesStep',
	#classTraits : 'TLensesStep classTrait',
	#instVars : [
		'parentStep'
	],
	#category : #'GToolkit-Lenses-Executors'
}

{ #category : #printing }
LensesResult >> gtDisplayOn: stream [

	stream nextPutAll: 'Result'
]

{ #category : #accessing }
LensesResult >> input [

	^ self initialInput
]

{ #category : #accessing }
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

{ #category : #enumerating }
LensesResult >> withParentsDo: aBlock [

	self parentStep withParentsDo: aBlock.
	aBlock cull: self
]
