Class {
	#name : #LensesRemoveProperty,
	#superclass : #Object,
	#traits : 'TLensesProperty',
	#classTraits : 'TLensesProperty classTrait',
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Lenses-Properties'
}

{ #category : #visiting }
LensesRemoveProperty >> accept: aVisitor [

	^ aVisitor visitLensesRemoveProperty: self
]

{ #category : #printing }
LensesRemoveProperty >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Remove ';
		nextPutAll: self name asString
]

{ #category : #accessing }
LensesRemoveProperty >> name [

	^ name
]

{ #category : #accessing }
LensesRemoveProperty >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesRemoveProperty >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPut: $)
]
