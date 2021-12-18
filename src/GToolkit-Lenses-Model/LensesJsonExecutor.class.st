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
		ifPresent: [ :aFirstValue :aFirstObject | 
			aFirstObject
				at: aLens secondName
				ifPresent: [ :aSecondValue | 
					| aNewValue |
					aNewValue := aLens formatValue: aFirstValue value: aSecondValue.
					aFirstObject at: aLens firstName put: aNewValue.
					aFirstObject removeKey: aLens secondName ]
				ifAbsent: [ "ignore" ] ]
		ifAbsent: [ :anObject | 
			anObject at: aLens firstName put: aLens defaultValue ]
]

{ #category : #accessing }
LensesJsonExecutor >> visitLensesPlungeLens: aLens [

	self assert: self step lens == aLens.

	"Copy (or initialize) the existing host value"
	self step
		at: aLens host
		ifPresent: [ :aHostValue | 
		self step at: aLens host put: aHostValue copy ]
		ifAbsent: [ self step at: aLens host put: aLens defaultValue ].

	"Plunge name"
	self step
		at: aLens name
		ifPresent: [ :aNameValue | 
			self step
				at: aLens host
				ifPresent: [ :aHostValue | 
					aHostValue at: aLens name put: aNameValue.
					self step removeKey: aLens name ]
				ifAbsent: [ 
					self error:
						('Host property is not available: {1}' format: aLens host) ] ]
		ifAbsent: [ 
			self step
				at: aLens host
				ifPresent: [ :aHostValue | 
					aHostValue at: aLens name put: aLens defaultValue ]
				ifAbsent: [ 
					self error:
						('Host property is not available: {1}' format: aLens host) ] ]
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
		ifPresent: [ :aValue :anObject | 
			anObject at: aLens destination put: aValue.
			anObject removeKey: aLens source ]
		ifAbsent: [ :anObject | 
			anObject at: aLens destination put: aLens defaultValue ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesSplitLens: aLens [

	self assert: self step lens == aLens.

	self step
		at: aLens name
		ifPresent: [ :aValue :anObject | 
			| aSubExpressions allDestinations |
			aSubExpressions := aLens splitter value: aValue.
			allDestinations := aLens allDestinations.

			aSubExpressions size >= allDestinations size
				ifTrue: [ 
					aLens allDestinations withIndexDo: [ :aDestination :anIndex | 
						aSubExpressions
							detect: [ :anAssoc | anAssoc key = anIndex ]
							ifFound: [ :anAssoc | 
								anObject
									at: aDestination
									put: anAssoc value ]
							ifNone: [ self error: 'Unexpected split error' ] ] ]
				ifFalse: [ self error: ('Cannot split value: {1}' format: aValue) ] ]
		ifAbsent: [ :anObject | anObject at: aLens name put: aLens defaultValue ]
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
