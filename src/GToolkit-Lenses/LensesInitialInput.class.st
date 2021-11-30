Class {
	#name : #LensesInitialInput,
	#superclass : #Object,
	#traits : 'TLensesStep',
	#classTraits : 'TLensesStep classTrait',
	#instVars : [
		'input'
	],
	#category : #'GToolkit-Lenses-Executors'
}

{ #category : #stack }
LensesInitialInput >> forProperty: aProperty [

	^ LensesChangeStep new
		  parentStep: self;
		  property: aProperty;
		  input: self input;
		  output: self input asOutput
]

{ #category : #printing }
LensesInitialInput >> gtDisplayOn: stream [

	stream nextPutAll: 'Initial input'
]

{ #category : #'gt - extensions' }
LensesInitialInput >> gtHistoryFor: aView [

	^ aView columnedList
		  title: 'Changes';
		  priority: 5;
		  items: [ { self } ];
		  column: 'Name' text: #yourself
]

{ #category : #enumerating }
LensesInitialInput >> initialInput [

	^ self input
]

{ #category : #accessing }
LensesInitialInput >> input [

	^ input
]

{ #category : #accessing }
LensesInitialInput >> input: anObject [

	input := anObject
]

{ #category : #accessing }
LensesInitialInput >> output [

	^ self input
]

{ #category : #enumerating }
LensesInitialInput >> withParentsDo: aBlock [

	aBlock cull: self
]
