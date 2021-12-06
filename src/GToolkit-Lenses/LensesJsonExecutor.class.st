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
LensesJsonExecutor >> visitLenses: aLenses [

	self visitManyLenses: aLenses lenses
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesAddLens: aLens [

	| anObject |
	self assert: self step lens == aLens.

	self step at: aLens name put: (aLens value)
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesConvertLens: aLens [

	self assert: self step lens == aLens.

	self step
		at: aLens name
		ifPresent: [ :aValue | 
			aLens
				convert: aValue
				ifPresent: [ :aNewValue | self step at: aLens name put: aNewValue ]
				ifAbsent: [ self step at: aLens name put: aLens defaultValue ] ]
		ifAbsent: [ self step at: aLens name put: aLens defaultValue ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesHeadLens: aLens [

	self assert: self step lens == aLens.

	self step
		at: aLens name
		ifPresent: [ :anArray | 
			anArray
				ifNotEmpty: [ 
					| aNewValue |
					aNewValue := anArray first.
					self step at: aLens name put: aNewValue ]
				ifEmpty: [ self step at: aLens name put: aLens defaultValue ] ]
		ifAbsent: [ self step at: aLens name put: aLens defaultValue ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesHoistLens: aLens [

	self assert: self step lens == aLens.

	self step
		at: aLens host
		ifPresent: [ :aValue | 
			| aSubValue |
			aSubValue := aValue at: aLens name ifAbsent: [ aLens defaultValue ].
			self step at: aLens name put: aSubValue. ]
		ifAbsent: [ 
			self step at: aLens name put: aLens defaultValue ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesInLens: aLens [

	| anInStep myChildren |
	anInStep := self step beScopedOutput.
	self visitManyLenses: aLens lenses.

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
LensesJsonExecutor >> visitLensesRemoveLens: aLens [

	self assert: self step lens == aLens.

	self step
		at: aLens name
		ifPresent: [ :aValue | self step removeKey: aLens name ]
		ifAbsent: [ "ignore" ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesRenameLens: aLens [

	self assert: self step lens == aLens.

	self step
		at: aLens source
		ifPresent: [ :aValue | 
			self step at: aLens destination put: aValue.
			self step removeKey: aLens source ]
		ifAbsent: [ 
		self step at: aLens destination put: aLens defaultValue ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitManyLenses: aCollection [

	aCollection do: [ :eachProperty | self visitOneLens: eachProperty ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitOneLens: aLens [

	currentStep := aLens nextStepFrom: currentStep.
	aLens accept: self.
]
