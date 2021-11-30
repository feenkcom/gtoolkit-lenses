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
	| aLenses anOutput |
	aLenses := self lensesWithTwoRenames.

	anOutput := aLenses transform:
		            (LensesJson forObject: (OrderedDictionary new
				              at: 'body' put: 'This is a description';
				              at: 'state' put: 'open';
				              yourself)).

	self assert: anOutput object size equals: 2.

	^ anOutput
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
