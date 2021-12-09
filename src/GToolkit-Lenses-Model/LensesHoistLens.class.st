Class {
	#name : #LensesHoistLens,
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
LensesHoistLens >> accept: aVisitor [

	^ aVisitor visitLensesHoistLens: self
]

{ #category : #printing }
LensesHoistLens >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].
	self host ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Hoist ';
		nextPutAll: self name asString;
		nextPutAll: ' from ';
		nextPutAll: self host asString
]

{ #category : #accessing }
LensesHoistLens >> host [

	^ host
]

{ #category : #accessing }
LensesHoistLens >> host: anObject [

	host := anObject
]

{ #category : #accessing }
LensesHoistLens >> name [

	^ name
]

{ #category : #accessing }
LensesHoistLens >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesHoistLens >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].
	self host ifNil: [ ^ self ].

	aStream
		nextPutAll: '(hoist ';
		nextPutAll: self name asString;
		nextPutAll: ' from ';
		nextPutAll: self host asString;
		nextPut: $)
]
