Class {
	#name : #LensesJsonExecutor,
	#superclass : #Object,
	#instVars : [
		'context',
		'lenses'
	],
	#category : #'GToolkit-Lenses-Executors'
}

{ #category : #accessing }
LensesJsonExecutor >> context [

	^ context
]

{ #category : #accessing }
LensesJsonExecutor >> context: anObject [

	context := anObject
]

{ #category : #execution }
LensesJsonExecutor >> execute [

	self lenses accept: self.
	
	context := LensesResult new parentStep: context.
]

{ #category : #'gt - extensions' }
LensesJsonExecutor >> gtChangesFor: aView [

	<gtView>
	self context ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Changes';
		  priority: 5;
		  object: [ self context ];
		  view: #gtHistoryFor:
]

{ #category : #'gt - extensions' }
LensesJsonExecutor >> gtInputFor: aView [

	<gtView>
	self context ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Input';
		  priority: 1;
		  object: [ self context initialInput ];
		  view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
LensesJsonExecutor >> gtOutputFor: aView [

	<gtView>
	self context ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Output';
		  priority: 2;
		  object: [ self context output ];
		  view: #gtLiveFor:
]

{ #category : #accessing }
LensesJsonExecutor >> lenses [

	^ lenses
]

{ #category : #accessing }
LensesJsonExecutor >> lenses: aLenses [

	lenses := aLenses
]

{ #category : #accessing }
LensesJsonExecutor >> output [

	^ self context output
]

{ #category : #visiting }
LensesJsonExecutor >> visitLenses: aProperty [

	self visitManyProperties: aProperty lenses
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesAddProperty: aProperty [

	| anObject |
	self assert: self context property == aProperty.
	self assert:
		(self context output object includesKey: aProperty name) not.

	anObject := self context output object copy.
	self context output object: anObject.

	anObject at: aProperty name put: (aProperty value)
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesInProperty: aProperty [

	| aChildInputObject aChildInput aChildOutputObject aChildOutput |
	aChildInputObject := self context input object at: aProperty name.
	aChildOutputObject := self context output object at: aProperty name.
	aChildInput := self context input asChildWith: aChildInputObject.
	aChildOutput := self context output asChildWith: aChildOutputObject.
	self context input: aChildInput.
	self context output: aChildOutput.

	"somehow set child as input"
	self visitManyProperties: aProperty lenses
	"somehow unset the child as input"
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesRemoveProperty: aProperty [

	| anObject |
	self assert: self context property == aProperty.

	anObject := self context output object copy.
	self context output object: anObject.

	anObject
		at: aProperty name
		ifPresent: [ :aValue | anObject removeKey: aProperty name ]
		ifAbsent: [ "ignore" ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesRenameProperty: aProperty [

	| anObject |
	self assert: self context property == aProperty.

	anObject := self context output object copy.
	self context output object: anObject.

	anObject
		at: aProperty source
		ifPresent: [ :aValue | 
			anObject at: aProperty destination put: aValue.
			anObject removeKey: aProperty source ]
		ifAbsent: [ 
		anObject at: aProperty destination put: aProperty defaultValue ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitManyProperties: aCollection [

	aCollection do: [ :eachProperty | self visitOneProperty: eachProperty ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitOneProperty: aProperty [

	context := context forProperty: aProperty.
	aProperty accept: self.
]
