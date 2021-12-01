Class {
	#name : #LensesJsonExecutor,
	#superclass : #Object,
	#instVars : [
		'lenses',
		'currentStep'
	],
	#category : #'GToolkit-Lenses-Executors'
}

{ #category : #execution }
LensesJsonExecutor >> execute [

	self lenses accept: self.
	
	currentStep := LensesResult new parentStep: currentStep.
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

{ #category : #accessing }
LensesJsonExecutor >> step [

	^ currentStep
]

{ #category : #accessing }
LensesJsonExecutor >> step: anObject [

	currentStep := anObject
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

	| anInStep myChildren |
	anInStep := self step beScopedOutput.
	self visitManyProperties: aProperty lenses.

	myChildren := Array streamContents: [ :aStream | 
		              | isInStep |
		              isInStep := false.
		              self step withPreviousStepsDo: [ :eachStep | 
			              isInStep
				              ifTrue: [ aStream nextPut: eachStep ]
				              ifFalse: [ 
				              eachStep == anInStep ifTrue: [ isInStep := true ] ] ] ].

	anInStep children: myChildren.
	anInStep beFullOutput.

	currentStep := anInStep
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesRemoveProperty: aProperty [

	self assert: self step property == aProperty.

	self step
		at: aProperty name
		ifPresent: [ :aValue | self step removeKey: aProperty name ]
		ifAbsent: [ "ignore" ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesRenameProperty: aProperty [

	self assert: self step property == aProperty.

	self step
		at: aProperty source
		ifPresent: [ :aValue | 
			self step at: aProperty destination put: aValue.
			self step removeKey: aProperty source ]
		ifAbsent: [ 
		self step at: aProperty destination put: aProperty defaultValue ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitManyProperties: aCollection [

	aCollection do: [ :eachProperty | self visitOneProperty: eachProperty ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitOneProperty: aProperty [

	currentStep := aProperty nextStepFrom: currentStep.
	aProperty accept: self.
]
