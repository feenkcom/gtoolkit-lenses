Class {
	#name : #LensesSplitLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name',
		'destinations',
		'splitter'
	],
	#category : #'GToolkit-Lenses-Model-Lenses'
}

{ #category : #visiting }
LensesSplitLens >> accept: aVisitor [

	^ aVisitor visitLensesSplitLens: self
]

{ #category : #accessing }
LensesSplitLens >> allDestinations [

	^ Array with: self name withAll: self destinations
]

{ #category : #accessing }
LensesSplitLens >> destinations [

	^ destinations
]

{ #category : #accessing }
LensesSplitLens >> destinations: anObject [

	destinations := anObject
]

{ #category : #printing }
LensesSplitLens >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Split ';
		nextPutAll: self name asString
]

{ #category : #accessing }
LensesSplitLens >> name [

	^ name
]

{ #category : #accessing }
LensesSplitLens >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesSplitLens >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPut: $)
]

{ #category : #accessing }
LensesSplitLens >> splitter [

	^ splitter
]

{ #category : #accessing }
LensesSplitLens >> splitter: anObject [

	splitter := anObject
]
