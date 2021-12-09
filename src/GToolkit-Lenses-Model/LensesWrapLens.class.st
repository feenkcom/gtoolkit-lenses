Class {
	#name : #LensesWrapLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Lenses-Model-Lenses'
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
