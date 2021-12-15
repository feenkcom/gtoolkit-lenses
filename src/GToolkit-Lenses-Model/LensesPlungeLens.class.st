Class {
	#name : #LensesPlungeLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name',
		'host'
	],
	#category : #'GToolkit-Lenses-Model-Lenses'
}

{ #category : #visiting }
LensesPlungeLens >> accept: aVisitor [

	^ aVisitor visitLensesPlungeLens: self
]

{ #category : #accessing }
LensesPlungeLens >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].
	self host ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Plunge ';
		nextPutAll: self name asString;
		nextPutAll: ' into ';
		nextPutAll: self host asString
]

{ #category : #accessing }
LensesPlungeLens >> host [

	^ host
]

{ #category : #accessing }
LensesPlungeLens >> host: anObject [

	host := anObject
]

{ #category : #accessing }
LensesPlungeLens >> name [

	^ name
]

{ #category : #accessing }
LensesPlungeLens >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesPlungeLens >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].
	self host ifNil: [ ^ self ].

	aStream
		nextPutAll: '(plunge ';
		nextPutAll: self name asString;
		nextPutAll: ' into ';
		nextPutAll: self host asString;
		nextPut: $)
]
