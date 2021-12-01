Class {
	#name : #LensesResult,
	#superclass : #Object,
	#traits : 'TLensesStep',
	#classTraits : 'TLensesStep classTrait',
	#instVars : [
		'parentStep'
	],
	#category : #'GToolkit-Lenses-Steps'
}

{ #category : #printing }
LensesResult >> gtDisplayOn: stream [

	stream nextPutAll: 'Result'
]

{ #category : #'gt - extensions' }
LensesResult >> gtHistoryFor: aView [

	<gtView>
	^ aView columnedTree
		  title: 'Steps';
		  priority: 5;
		  items: [ self withPreviousSteps ];
		  children: #gtHistoryStepChildren;
		  expandAll;
		  column: 'Name' text: #yourself
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
