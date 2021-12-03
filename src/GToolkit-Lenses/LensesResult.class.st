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
		  column: 'Steps' text: #yourself
]

{ #category : #'gt - extensions' }
LensesResult >> gtStepsInputAndOutputViewFor: aView [

	<gtView>
	^ aView explicit
		  title: 'Result';
		  priority: 0;
		  stencil: [ 
			  | aSteps anInput anOutput |
			  aSteps := GtInspector
				            forObject: self
				            viewSelector: #gtHistoryFor:.
			  aSteps constraintsDo: [ :c | c linear weight: 0.5 ].
			  aSteps border:
					  (BlBorder
						   paint: BrGlamorousColors disabledButtonBorderColor
						   width: 1).
			  aSteps when: GtPhlowObjectToSpawn do: [ :anEvent | 
					  anEvent consumed: true.
					  NonInteractiveTranscript stdout
						  show: anEvent;
						  cr.
					  anInput
						  object: anEvent object
						  viewSelector: #gtInputFor:context:.
					  anOutput
						  object: anEvent object
						  viewSelector: #gtOutputFor: ].
			  aSteps when: GtPhlowObjectToSelect do: [ :anEvent | 
				  anEvent consumed: true.
				  anInput
					  object: anEvent object
					  viewSelector: #gtInputFor:context:.
				  anOutput
					  object: anEvent object
					  viewSelector: #gtOutputFor: ].

			  anInput := GtInspector
				             forObject: self
				             viewSelector: #gtInputFor:context:.
			  anInput border:
				  (BlBorder
					   paint: BrGlamorousColors disabledButtonBorderColor
					   width: 1).
			  anInput margin: (BlInsets left: 10 right: 10).

			  anOutput := GtInspector
				              forObject: self
				              viewSelector: #gtOutputFor:.
			  anOutput border:
				  (BlBorder
					   paint: BrGlamorousColors disabledButtonBorderColor
					   width: 1).

			  BrHorizontalPane new
				  padding: (BlInsets all: 10);
				  matchParent;
				  addChild: aSteps;
				  addChild: anInput;
				  addChild: anOutput ]
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
