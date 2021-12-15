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

	aResult := aLenses execute: (Dictionary new
			            at: 'body' put: 'This is a description';
			            at: 'state' put: 'open';
			            at: 'label' put: (Dictionary new
					             at: 'id' put: 23434267;
					             at: 'name' put: 'bug';
					             yourself);
			            yourself).

	self assert: aResult output object size equals: 3.

	^ aResult
]

{ #category : #accessing }
LensesExamples >> executeIssueTrackerLenses [

	<gtExample>
	| aLenses aResult |
	aLenses := self lensesForIssueTracker.

	aResult := aLenses execute: self originalIssueTrackerJsonString.

	self assert: aResult output object size equals: 5.

	^ aResult
]

{ #category : #'examples - reversed' }
LensesExamples >> executeReversedIssueTrackerLenses [

	<gtExample>
	| aLenses aResult anInput |
	aLenses := self reversedLensesForIssueTracker.
	anInput := self executeIssueTrackerLenses output object.

	aResult := aLenses execute: anInput.

	"self assert: aResult output object size equals: 5."

	^ aResult
]

{ #category : #'examples - lenses' }
LensesExamples >> executeTwoRenames [

	<gtExample>
	| aLenses aResult |
	aLenses := self lensesWithTwoRenames.

	aResult := aLenses execute: (Dictionary new
			            at: 'body' put: 'This is a description';
			            at: 'state' put: 'open';
			            yourself).

	self assert: aResult output object size equals: 2.

	^ aResult
]

{ #category : #'examples - lenses' }
LensesExamples >> executeTwoRenamesOneRemove [

	<gtExample>
	| aLenses aResult |
	aLenses := self lensesWithTwoRenamesOneRemove.

	aResult := aLenses execute: (Dictionary new
			            at: 'body' put: 'This is a description';
			            at: 'state' put: 'open';
			            at: 'labels' put: {  };
			            yourself).

	self assert: aResult output object size equals: 2.

	^ aResult
]

{ #category : #'examples - lenses' }
LensesExamples >> executeTwoRenamesOneRemoveOneAdd [

	<gtExample>
	| aLenses aResult |
	aLenses := self lensesWithTwoRenamesOneRemoveOneAdd.

	aResult := aLenses execute: (Dictionary new
			            at: 'body' put: 'This is a description';
			            at: 'state' put: 'open';
			            at: 'labels' put: { 'enhancement'. 'todo' };
			            yourself).

	self assert: aResult output object size equals: 3.

	^ aResult
]

{ #category : #'examples - lenses' }
LensesExamples >> lensesForIssueTracker [

	<gtExample>
	| aLenses |
	aLenses := self basicLenses.

	aLenses name: 'Issue Tracker'.
	aLenses lenses: { 
			(LensesRenameLens new
				 source: 'body';
				 destination: 'description').
			(LensesRenameLens new
				 source: 'state';
				 destination: 'status').
			(LensesConvertLens new
				 name: 'status';
				 convert: 'open' into: 'todo';
				 convert: 'closed' into: 'done').
			(LensesHeadLens new name: 'labels').
			(LensesInLens new
				 name: 'labels';
				 lenses: { (LensesRenameLens new
						  source: 'name';
						  destination: 'category') }).
			(LensesHoistLens new
				 name: 'category';
				 host: 'labels').
			(LensesRemoveLens new
				 name: 'labels';
				 defaultValue: Dictionary new )}.

	self assert: aLenses lenses size equals: 7.

	^ aLenses
]

{ #category : #'examples - lenses' }
LensesExamples >> lensesWithInProperty [

	<gtExample>
	| aLenses |
	aLenses := self basicLenses.

	aLenses lenses: { (LensesInLens new
			 name: 'label';
			 lenses: { 
					 (LensesRenameLens new
						  source: 'name';
						  destination: 'category').
					 (LensesRemoveLens new name: 'id') }) }.

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
			(LensesRenameLens new
				 source: 'body';
				 destination: 'description').
			(LensesRenameLens new
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
			(LensesRenameLens new
				 source: 'body';
				 destination: 'description').
			(LensesRenameLens new
				 source: 'state';
				 destination: 'status').
			(LensesRemoveLens new 
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
			(LensesRenameLens new
				 source: 'body';
				 destination: 'description').
			(LensesRenameLens new
				 source: 'state';
				 destination: 'status').
			(LensesRemoveLens new 
				 name: 'labels').
			(LensesAddLens new
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

{ #category : #'examples - json' }
LensesExamples >> parseIssueTrackerJsonString [

	<gtExample>
	| aLenses aString |
	aString := self writeIssueTrackerJsonString.

	aLenses := LensesJsonReader fromString: aString.

	self assert: aLenses isNotNil.
	self assert: aLenses class equals: Lenses.

	^ aLenses
]

{ #category : #'examples - reversed' }
LensesExamples >> reversedLensesForIssueTracker [

	<gtExample>
	| aLenses |
	aLenses := self lensesForIssueTracker reversed.
	
	self assert: aLenses lenses size equals: 7.

	^ aLenses
]

{ #category : #'examples - json' }
LensesExamples >> writeIssueTrackerJsonString [

	<gtExample>
	| aLenses aString |
	aLenses := self lensesForIssueTracker.
	aString := aLenses asJsonString.
	
	self assert: aString isString.
	self assert: aString isNotEmpty.
	
	^ aString
	
]
