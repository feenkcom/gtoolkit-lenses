Class {
	#name : #LensesMergeLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'firstName',
		'secondName',
		'format'
	],
	#category : #'GToolkit-Lenses-Model-Lenses'
}

{ #category : #visiting }
LensesMergeLens >> accept: aVisitor [

	^ aVisitor visitLensesMergeLens: self
]

{ #category : #accessing }
LensesMergeLens >> firstName [

	^ firstName
]

{ #category : #accessing }
LensesMergeLens >> firstName: anObject [

	firstName := anObject
]

{ #category : #accessing }
LensesMergeLens >> format [

	^ format
]

{ #category : #accessing }
LensesMergeLens >> format: aFormat [

	format := aFormat asLensesFormater
]

{ #category : #converting }
LensesMergeLens >> formatValue: aFirstValue value: aSecondValue [

	^ self format value: aFirstValue value: aSecondValue
]

{ #category : #printing }
LensesMergeLens >> gtDisplayOn: aStream [

	self firstName ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].
	self secondName ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Merge ';
		nextPutAll: self firstName asString;
		nextPutAll: ' and ';
		nextPutAll: self secondName asString
]

{ #category : #printing }
LensesMergeLens >> printOn: aStream [

	super printOn: aStream.

	self firstName ifNil: [ ^ self ].
	self secondName ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self firstName asString;
		nextPutAll: ' and ';
		print: self secondName asString;
		nextPut: $)
]

{ #category : #accessing }
LensesMergeLens >> secondName [

	^ secondName
]

{ #category : #accessing }
LensesMergeLens >> secondName: anObject [

	secondName := anObject
]
