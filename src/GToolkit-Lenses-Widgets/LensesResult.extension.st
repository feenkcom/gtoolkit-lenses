Extension { #name : #LensesResult }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesResult >> gtHistoryFor: aView [

	<gtView>
	^ aView columnedTree
		  title: 'Steps';
		  priority: 5;
		  items: [ self withPreviousSteps ];
		  children: #gtHistoryStepChildren;
		  expandAll;
		  column: 'Steps' text: #gtHistoryStepItemDisplayText
]

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesResult >> gtStepsInputAndOutputViewFor: aView [

	<gtView>
	^ aView explicit
		  title: 'Result (Object)';
		  priority: 0;
		  stencil: [ 
			  | aSteps anInput anOutput |
			  aSteps := GtInspector
				            forObject: self
				            viewSelector: #gtHistoryFor:.
			  aSteps constraintsDo: [ :c | c linear weight: 0.5 ].
			  aSteps background: Color white;
			  	aptitude: BrShadowAptitude;
			  	margin: (BlInsets all: 10).
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
						  viewSelector: #gtOutputFor:context: ].
			  aSteps when: GtPhlowObjectToSelect do: [ :anEvent | 
				  anEvent consumed: true.
				  anInput
					  object: anEvent object
					  viewSelector: #gtInputFor:context:.
				  anOutput
					  object: anEvent object
					  viewSelector: #gtOutputFor:context: ].

			  anInput := GtInspector
				             forObject: self
				             viewSelector: #gtInputFor:context:.
			  anInput 
			  	background: Color white;
			  	aptitude: BrShadowAptitude;
			  	margin: (BlInsets all: 10).

			  anOutput := GtInspector
				              forObject: self
				              viewSelector: #gtOutputFor:context:.
			  anOutput background: Color white;
			  	aptitude: BrShadowAptitude;
			  	margin: (BlInsets all: 10).

			  BrHorizontalPane new
				  padding: (BlInsets all: 10);
				  matchParent;
				  addChild: aSteps;
				  addChild: anInput;
				  addChild: anOutput ]
]

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesResult >> gtStepsTextInputAndOutputViewFor: aView [

	<gtView>
	^ aView explicit
		  title: 'Result (Text)';
		  priority: 0;
		  stencil: [ 
			  | aSteps anInput anOutput |
			  aSteps := GtInspector
				            forObject: self
				            viewSelector: #gtHistoryFor:.
			  aSteps constraintsDo: [ :c | c linear weight: 0.5 ].
			  aSteps background: Color white;
			  	aptitude: BrShadowAptitude;
			  	margin: (BlInsets all: 10).

			  aSteps when: GtPhlowObjectToSpawn do: [ :anEvent | 
					  anEvent consumed: true.
					  NonInteractiveTranscript stdout
						  show: anEvent;
						  cr.
					  anInput
						  object: anEvent object
						  viewSelector: #gtInputTextFor:context:.
					  anOutput
						  object: anEvent object
						  viewSelector: #gtOutputTextFor:context: ].

			  aSteps when: GtPhlowObjectToSelect do: [ :anEvent | 
				  anEvent consumed: true.
				  anInput
					  object: anEvent object
					  viewSelector: #gtInputTextFor:context:.
				  anOutput
					  object: anEvent object
					  viewSelector: #gtOutputTextFor:context: ].

			  anInput := GtInspector
				             forObject: self
				             viewSelector: #gtInputTextFor:context:.
			  anInput background: Color white;
			  	aptitude: BrShadowAptitude;
			  	margin: (BlInsets all: 10).

			  anOutput := GtInspector
				              forObject: self
				              viewSelector: #gtOutputTextFor:context:.
			  anOutput background: Color white;
			  	aptitude: BrShadowAptitude;
			  	margin: (BlInsets all: 10).

			  BrHorizontalPane new
				  padding: (BlInsets all: 10);
				  matchParent;
				  addChild: aSteps;
				  addChild: anInput;
				  addChild: anOutput ]
]
