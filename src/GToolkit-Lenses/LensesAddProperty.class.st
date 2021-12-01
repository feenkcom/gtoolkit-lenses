Class {
	#name : #LensesAddProperty,
	#superclass : #Object,
	#traits : 'TLensesProperty',
	#classTraits : 'TLensesProperty classTrait',
	#instVars : [
		'name',
		'value'
	],
	#category : #'GToolkit-Lenses-Properties'
}

{ #category : #visiting }
LensesAddProperty >> accept: aVisitor [

	^ aVisitor visitLensesAddProperty: self
]

{ #category : #printing }
LensesAddProperty >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Add ';
		nextPutAll: self name asString;
		nextPutAll: ': ';
		nextPutAll: self value asString
]

{ #category : #accessing }
LensesAddProperty >> name [

	^ name
]

{ #category : #accessing }
LensesAddProperty >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesAddProperty >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPutAll: ': ';
		nextPutAll: self value asString;
		nextPut: $)
]

{ #category : #accessing }
LensesAddProperty >> value [

	^ value
]

{ #category : #accessing }
LensesAddProperty >> value: anObject [

	value := anObject
]
