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

{ #category : #'as yet unclassified' }
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
