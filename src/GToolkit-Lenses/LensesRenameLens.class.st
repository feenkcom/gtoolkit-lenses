Class {
	#name : #LensesRenameLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'source',
		'destination'
	],
	#category : #'GToolkit-Lenses-Lenses'
}

{ #category : #visiting }
LensesRenameLens >> accept: aVisitor [

	^ aVisitor visitLensesRenameLens: self
]

{ #category : #accessing }
LensesRenameLens >> destination [

	^ destination
]

{ #category : #accessing }
LensesRenameLens >> destination: anObject [

	destination := anObject
]

{ #category : #printing }
LensesRenameLens >> gtDisplayOn: aStream [

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
LensesRenameLens >> gtHistoryStepItemDisplayText [

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
LensesRenameLens >> printOn: aStream [

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
LensesRenameLens >> source [

	^ source
]

{ #category : #accessing }
LensesRenameLens >> source: anObject [

	source := anObject
]
