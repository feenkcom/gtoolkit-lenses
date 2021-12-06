Class {
	#name : #LensesConvertLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name',
		'toMapping'
	],
	#category : #'GToolkit-Lenses-Lenses'
}

{ #category : #visiting }
LensesConvertLens >> accept: aVisitor [

	^ aVisitor visitLensesConvertLens: self
]

{ #category : #accessing }
LensesConvertLens >> convert: anOldValue ifPresent: presentBlock ifAbsent: absentBlock [

	self toMapping
		at: anOldValue
		ifPresent: presentBlock
		ifAbsent: absentBlock
]

{ #category : #accessing }
LensesConvertLens >> convert: anOldValue into: aNewValue [

	self toMapping at: anOldValue put: aNewValue
]

{ #category : #printing }
LensesConvertLens >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].
	self toMapping ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Convert ';
		nextPutAll: self name asString
]

{ #category : #'gt - extensions' }
LensesConvertLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'Convert ' asRopedText.
	aName := LensesUtility styleKey: self name.

	aText append: aName.

	^ aText
]

{ #category : #initialization }
LensesConvertLens >> initialize [

	super initialize.

	toMapping := OrderedDictionary new
]

{ #category : #accessing }
LensesConvertLens >> name [

	^ name
]

{ #category : #accessing }
LensesConvertLens >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesConvertLens >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].
	self toMapping ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPutAll: ', ';
		print: self toMapping size;
		nextPutAll: (' mapping' asPluralBasedOn: self toMapping size);
		nextPut: $)
]

{ #category : #accessing }
LensesConvertLens >> toMapping [

	^ toMapping
]

{ #category : #accessing }
LensesConvertLens >> toMapping: aDictionary [

	toMapping := aDictionary
]
