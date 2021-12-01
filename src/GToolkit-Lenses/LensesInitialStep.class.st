Class {
	#name : #LensesInitialStep,
	#superclass : #Object,
	#traits : 'TLensesStep',
	#classTraits : 'TLensesStep classTrait',
	#instVars : [
		'input'
	],
	#category : #'GToolkit-Lenses-Steps'
}

{ #category : #stack }
LensesInitialStep >> forProperty: aProperty [

	^ LensesTransformationStep new
		  parentStep: self;
		  property: aProperty;
		  input: self input;
		  output: self input asOutput
]

{ #category : #printing }
LensesInitialStep >> gtDisplayOn: stream [

	stream nextPutAll: 'Initial input'
]

{ #category : #'gt - extensions' }
LensesInitialStep >> gtHistoryFor: aView [

	^ aView columnedList
		  title: 'Changes';
		  priority: 5;
		  items: [ { self } ];
		  column: 'Name' text: #yourself
]

{ #category : #'gt - extensions' }
LensesInitialStep >> gtOutputFor: aView [

	^ aView empty
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
