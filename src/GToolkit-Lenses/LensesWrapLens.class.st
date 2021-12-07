Class {
	#name : #LensesWrapLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Lenses-Lenses'
}

{ #category : #visiting }
LensesWrapLens >> accept: aVisitor [

	^ aVisitor visitLensesWrapLens: self
]

{ #category : #printing }
LensesWrapLens >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Wrap ';
		nextPutAll: self name asString
]

{ #category : #'gt - extensions' }
LensesWrapLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'Wrap ' asRopedText.
	aName := LensesUtility styleKey: self name.

	aText append: aName.

	^ aText
]

{ #category : #accessing }
LensesWrapLens >> name [

	^ name
]

{ #category : #accessing }
LensesWrapLens >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesWrapLens >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPutAll: '(';
		nextPutAll: self name asString;
		nextPut: $)
]
