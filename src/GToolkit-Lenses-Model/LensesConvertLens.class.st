Class {
	#name : #LensesConvertLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name',
		'toMapping',
		'reversedMapping'
	],
	#category : #'GToolkit-Lenses-Model-Lenses'
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

{ #category : #private }
LensesConvertLens >> createReversedMapping [

	| aDictionary |
	aDictionary := Dictionary new: self toMapping size.
	
	self toMapping keysAndValuesDo: [ :aKey :aValue | 
		aDictionary at: aValue put: aKey ].
		
	^ aDictionary
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

{ #category : #'api - lenses' }
LensesConvertLens >> reversed [

	"Return lenses for reversed transformation"

	^ self class new
		  name: self name;
		  toMapping: self reversedMapping;
		  reversedMapping: self toMapping
]

{ #category : #accessing }
LensesConvertLens >> reversedMapping [

	^ reversedMapping ifNil: [ 
		  reversedMapping := self createReversedMapping ]
]

{ #category : #accessing }
LensesConvertLens >> reversedMapping: aDictionary [

	reversedMapping := aDictionary
]

{ #category : #accessing }
LensesConvertLens >> toMapping [

	^ toMapping
]

{ #category : #accessing }
LensesConvertLens >> toMapping: aDictionary [

	toMapping := aDictionary
]
