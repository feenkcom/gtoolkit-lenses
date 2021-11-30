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

{ #category : #accessing }
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
		nextPutAll: self destination asString;
		nextPut: $)
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
