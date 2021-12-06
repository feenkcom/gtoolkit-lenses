Class {
	#name : #LensesRemoveLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Lenses-Lenses'
}

{ #category : #visiting }
LensesRemoveLens >> accept: aVisitor [

	^ aVisitor visitLensesRemoveLens: self
]

{ #category : #printing }
LensesRemoveLens >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Remove ';
		nextPutAll: self name asString
]

{ #category : #'gt - extensions' }
LensesRemoveLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'Rename ' asRopedText.
	aName := LensesUtility styleKey: self name.

	aText append: aName.

	^ aText
]

{ #category : #accessing }
LensesRemoveLens >> name [

	^ name
]

{ #category : #accessing }
LensesRemoveLens >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesRemoveLens >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPut: $)
]
