Class {
	#name : #LensesRenameLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'source',
		'destination'
	],
	#category : #'GToolkit-Lenses-Model-Lenses'
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

{ #category : #'api - lenses' }
LensesRenameLens >> reversed [

	"Return lenses for reversed transformation"

	^ self class new
		  source: self destination;
		  destination: self source
]

{ #category : #accessing }
LensesRenameLens >> source [

	^ source
]

{ #category : #accessing }
LensesRenameLens >> source: anObject [

	source := anObject
]
