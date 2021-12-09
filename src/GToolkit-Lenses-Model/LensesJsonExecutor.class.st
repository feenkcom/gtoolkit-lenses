Class {
	#name : #LensesJsonExecutor,
	#superclass : #Object,
	#instVars : [
		'lenses',
		'currentStep'
	],
	#category : #'GToolkit-Lenses-Model-Executors'
}

{ #category : #execution }
LensesJsonExecutor >> execute [

	self lenses accept: self.
	
	currentStep := LensesResult new parentStep: currentStep.
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
LensesJsonExecutor >> visitLensesMergeLens: aLens [

	self assert: self step lens == aLens.

	self step
		at: aLens firstName
		ifPresent: [ :aFirstValue | 
			self step
				at: aLens secondName
				ifPresent: [ :aSecondValue | 
					| aNewValue |
					aNewValue := aLens formatValue: aFirstValue value: aSecondValue.
					self step at: aLens firstName put: aNewValue.
					self step removeKey: aLens secondName ]
				ifAbsent: [ "ignore" ] ]
		ifAbsent: [ self step at: aLens firstName put: aLens defaultValue ]
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
LensesJsonExecutor >> visitLensesSplitLens: aLens [

	self assert: self step lens == aLens.

	self step
		at: aLens name
		ifPresent: [ :aValue | 
			| aSubExpressions allDestinations |
			aSubExpressions := aLens splitter value: aValue.
			allDestinations := aLens allDestinations.

			aSubExpressions size >= allDestinations size
				ifTrue: [ 
					aLens allDestinations withIndexDo: [ :aDestination :anIndex | 
						aSubExpressions
							detect: [ :anAssoc | anAssoc key = anIndex ]
							ifFound: [ :anAssoc | 
								self step
									at: aDestination
									put: anAssoc value ]
							ifNone: [ self error: 'Unexpected split error' ] ] ]
				ifFalse: [ self error: ('Cannot split value: {1}' format: aValue) ] ]
		ifAbsent: [ self step at: aLens name put: aLens defaultValue ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesWrapLens: aLens [

	self assert: self step lens == aLens.

	self step
		at: aLens name
		ifPresent: [ :anObject | 
			| aNewValue |
			aNewValue := aLens listClass with: anObject.
			self step at: aLens name put: aNewValue ]
		ifAbsent: [ self step at: aLens name put: aLens defaultValue ]
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
