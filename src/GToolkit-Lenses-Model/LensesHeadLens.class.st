Class {
	#name : #LensesHeadLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Lenses-Model-Lenses'
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

{ #category : #'api - lenses' }
LensesHeadLens >> reversed [

	"Return lenses for reversed transformation"

	^ LensesWrapLens new name: self name
]
