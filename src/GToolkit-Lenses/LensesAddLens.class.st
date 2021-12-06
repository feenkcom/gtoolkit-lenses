Class {
	#name : #LensesAddLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name',
		'value'
	],
	#category : #'GToolkit-Lenses-Lenses'
}

{ #category : #visiting }
LensesAddLens >> accept: aVisitor [

	^ aVisitor visitLensesAddLens: self
]

{ #category : #printing }
LensesAddLens >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Add ';
		nextPutAll: self name asString;
		nextPutAll: ': ';
		nextPutAll: self value asString
]

{ #category : #'gt - extensions' }
LensesAddLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'Add ' asRopedText.
	aName := LensesUtility styleKey: self name.

	aText append: aName.

	^ aText
]

{ #category : #accessing }
LensesAddLens >> name [

	^ name
]

{ #category : #accessing }
LensesAddLens >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesAddLens >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPutAll: ': ';
		nextPutAll: self value asString;
		nextPut: $)
]

{ #category : #accessing }
LensesAddLens >> value [

	^ value
]

{ #category : #accessing }
LensesAddLens >> value: anObject [

	value := anObject
]