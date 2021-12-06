Class {
	#name : #LensesHeadLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Lenses-Lenses'
}

{ #category : #visiting }
LensesHeadLens >> accept: aVisitor [

	^ aVisitor visitLensesHeadLens: self
]

{ #category : #printing }
LensesHeadLens >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Head in ';
		nextPutAll: self name asString
]

{ #category : #'gt - extensions' }
LensesHeadLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'Head in ' asRopedText.
	aName := LensesUtility styleKey: self name.

	aText append: aName.

	^ aText
]

{ #category : #accessing }
LensesHeadLens >> name [

	^ name
]

{ #category : #accessing }
LensesHeadLens >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesHeadLens >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPutAll: '(';
		nextPutAll: self name asString;
		nextPut: $)
]
