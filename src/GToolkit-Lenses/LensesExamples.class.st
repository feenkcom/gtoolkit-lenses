Class {
	#name : #LensesExamples,
	#superclass : #Object,
	#category : #'GToolkit-Lenses-Examples'
}

{ #category : #'examples - lenses' }
LensesExamples >> basicLenses [

	<gtExample>
	| aLenses |
	aLenses := Lenses new.

	self assert: aLenses name equals: ''.
	self assert: aLenses lenses equals: #(  ).

	^ aLenses
]

{ #category : #'examples - lenses' }
LensesExamples >> executeTwoRenames [

	<gtExample>
	| aLenses aResult |
	aLenses := self lensesWithTwoRenames.

	aResult := aLenses execute:
		            (LensesJson forObject: (OrderedDictionary new
				              at: 'body' put: 'This is a description';
				              at: 'state' put: 'open';
				              yourself)).

	self assert: aResult output object size equals: 2.

	^ aResult
]

{ #category : #'examples - lenses' }
LensesExamples >> executeTwoRenamesOneRemove [

	<gtExample>
	| aLenses aResult |
	aLenses := self lensesWithTwoRenamesOneRemove.

	aResult := aLenses execute:
		           (LensesJson forObject: (OrderedDictionary new
				             at: 'body' put: 'This is a description';
				             at: 'state' put: 'open';
				             at: 'labels' put: {  };
				             yourself)).

	self assert: aResult output object size equals: 2.

	^ aResult
]

{ #category : #'examples - lenses' }
LensesExamples >> lensesWithTwoRenames [

	<gtExample>
	| aLenses |
	aLenses := Lenses new.

	aLenses lenses: { 
			(LensesRenameProperty new
				 source: 'body';
				 destination: 'description').
			(LensesRenameProperty new
				 source: 'state';
				 destination: 'status') }.

	self assert: aLenses lenses size equals: 2.

	^ aLenses
]

{ #category : #'examples - lenses' }
LensesExamples >> lensesWithTwoRenamesOneRemove [

	<gtExample>
	| aLenses |
	aLenses := self basicLenses.

	aLenses lenses: { 
			(LensesRenameProperty new
				 source: 'body';
				 destination: 'description').
			(LensesRenameProperty new
				 source: 'state';
				 destination: 'status').
			(LensesRemoveProperty new 
				 name: 'labels') }.

	self assert: aLenses lenses size equals: 3.

	^ aLenses
]
