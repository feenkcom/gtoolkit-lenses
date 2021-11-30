Class {
	#name : #LensesChangeStep,
	#superclass : #Object,
	#traits : 'TLensesStep',
	#classTraits : 'TLensesStep classTrait',
	#instVars : [
		'property',
		'input',
		'output',
		'parentStep'
	],
	#category : #'GToolkit-Lenses-Executors'
}

{ #category : #stack }
LensesChangeStep >> forProperty: aProperty [

	^ LensesChangeStep new
		  parentStep: self;
		  property: aProperty;
		  input: self output;
		  output: self output asOutput
]

{ #category : #printing }
LensesChangeStep >> gtDisplayOn: stream [

	self property ifNil: [ 
		super gtDisplayOn: stream.
		^ self ].

	self property gtDisplayOn: stream
]

{ #category : #accessing }
LensesChangeStep >> input [

	^ input
]

{ #category : #accessing }
LensesChangeStep >> input: anObject [

	input := anObject
]

{ #category : #accessing }
LensesChangeStep >> output [

	^ output
]

{ #category : #accessing }
LensesChangeStep >> output: anObject [

	output := anObject
]

{ #category : #accessing }
LensesChangeStep >> parentStep [

	^ parentStep
]

{ #category : #accessing }
LensesChangeStep >> parentStep: anObject [

	parentStep := anObject
]

{ #category : #accessing }
LensesChangeStep >> property [

	^ property
]

{ #category : #accessing }
LensesChangeStep >> property: anObject [

	property := anObject
]

{ #category : #enumerating }
LensesChangeStep >> withParentsDo: aBlock [

	self parentStep withParentsDo: aBlock.
	aBlock cull: self
]
