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

{ #category : #accessing }
LensesExamples >> executeInProperty [

	<gtExample>
	| aLenses aResult |
	aLenses := self lensesWithInProperty.

	aResult := aLenses execute: (LensesInitialJsonObject forObject: (Dictionary new
				             at: 'body' put: 'This is a description';
				             at: 'state' put: 'open';
				             at: 'label' put: (Dictionary new
						              at: 'id' put: 23434267;
						              at: 'name' put: 'bug';
						              yourself);
				             yourself)).

	self assert: aResult output object size equals: 3.

	^ aResult
]

{ #category : #accessing }
LensesExamples >> executeIssueTrackerLenses [

	<gtExample>
	| aLenses aResult |
	aLenses := self lensesForIssueTracker.

	aResult := aLenses execute: self originalIssueTrackerJsonString.

	self assert: aResult output object size equals: 4.

	^ aResult
]

{ #category : #'examples - lenses' }
LensesExamples >> executeTwoRenames [

	<gtExample>
	| aLenses aResult |
	aLenses := self lensesWithTwoRenames.

	aResult := aLenses execute:
		            (LensesInitialJsonObject forObject: (OrderedDictionary new
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
		           (LensesInitialJsonObject forObject: (OrderedDictionary new
				             at: 'body' put: 'This is a description';
				             at: 'state' put: 'open';
				             at: 'labels' put: {  };
				             yourself)).

	self assert: aResult output object size equals: 2.

	^ aResult
]

{ #category : #accessing }
LensesExamples >> executeTwoRenamesOneRemoveOneAdd [

	<gtExample>
	| aLenses aResult |
	aLenses := self lensesWithTwoRenamesOneRemoveOneAdd.

	aResult := aLenses execute:
		           (LensesInitialJsonObject forObject: (OrderedDictionary new
				             at: 'body' put: 'This is a description';
				             at: 'state' put: 'open';
				             at: 'labels' put: { 'enhancement'. 'todo' };
				             yourself)).

	self assert: aResult output object size equals: 3.

	^ aResult
]

{ #category : #accessing }
LensesExamples >> lensesForIssueTracker [

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
			(LensesInProperty new
				 name: 'labels';
				 lenses: { (LensesRenameProperty new
						  source: 'name';
						  destination: 'category') }).
			(LensesRemoveProperty new name: 'labels') }.

	self assert: aLenses lenses size equals: 4.

	^ aLenses
]

{ #category : #accessing }
LensesExamples >> lensesWithInProperty [

	<gtExample>
	| aLenses |
	aLenses := self basicLenses.

	aLenses lenses: { (LensesInProperty new
			 name: 'label';
			 lenses: { 
					 (LensesRenameProperty new
						  source: 'name';
						  destination: 'category').
					 (LensesRemoveProperty new name: 'id') }) }.

	self assert: aLenses lenses size equals: 1.
	self assert: aLenses lenses first lenses size equals: 2.

	^ aLenses
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

{ #category : #accessing }
LensesExamples >> lensesWithTwoRenamesOneRemoveOneAdd [

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
				 name: 'labels').
			(LensesAddProperty new
				 name: 'options';
				 value: #(  )) }.

	self assert: aLenses lenses size equals: 4.

	^ aLenses
]

{ #category : #accessing }
LensesExamples >> originalIssueTrackerJsonObject [

	<gtExample>
	^ STONJSON fromString: self originalIssueTrackerJsonString
]

{ #category : #'examples - lenses' }
LensesExamples >> originalIssueTrackerJsonString [

	<gtExample>
	
	^ '{
    "id": 1,
    "state": "open",
    "title": "Found a bug",
    "body": "I''m having a problem with this.",
    "labels": [
      {
        "id": 208045946,
        "node_id": "MDU6TGFiZWwyMDgwNDU5NDY=",
        "url": "https://api.github.com/repos/octocat/Hello-World/labels/bug",
        "name": "bug",
        "description": "Something isn''t working",
        "color": "f29513",
        "default": true
      }
    ]
  }'
]
