Class {
	#name : #LensesRenameProperty,
	#superclass : #Object,
	#traits : 'TLensesProperty',
	#classTraits : 'TLensesProperty classTrait',
	#instVars : [
		'source',
		'destination'
	],
	#category : #'GToolkit-Lenses-Properties'
}

{ #category : #visiting }
LensesRenameProperty >> accept: aVisitor [

	^ aVisitor visitLensesRenameProperty: self
]

{ #category : #accessing }
LensesRenameProperty >> destination [

	^ destination
]

{ #category : #accessing }
LensesRenameProperty >> destination: anObject [

	destination := anObject
]

{ #category : #printing }
LensesRenameProperty >> gtDisplayOn: aStream [

	self source ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].
	self destination ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Rename ';
		nextPutAll: self source asString;
		nextPutAll: ' to ';
		nextPutAll: self destination asString
]

{ #category : #'gt - extensions' }
LensesRenameProperty >> gtHistoryStepItemDisplayText [

	| aText aSource aDestination |
	self source ifNil: [ ^ self gtDisplayString ].
	self destination ifNil: [ ^ self gtDisplayString ].

	aText := 'Rename ' asRopedText.
	aSource := LensesUtility styleKey: self source.
	aDestination := LensesUtility styleKey: self destination.

	aText
		append: aSource;
		append: ' to ' asRopedText;
		append: aDestination.

	^ aText
]

{ #category : #printing }
LensesRenameProperty >> printOn: aStream [

	super printOn: aStream.

	self source ifNil: [ ^ self ].
	self destination ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self source asString;
		nextPutAll: ' -> ';
		nextPutAll: self destination asString;
		nextPut: $)
]

{ #category : #accessing }
LensesRenameProperty >> source [

	^ source
]

{ #category : #accessing }
LensesRenameProperty >> source: anObject [

	source := anObject
]
