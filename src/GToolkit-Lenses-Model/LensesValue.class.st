Class {
	#name : #LensesValue,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Lenses-Model-Support'
}

{ #category : #'instance creation' }
LensesValue class >> value: anObject [

	^ self new value: anObject
]

{ #category : #printing }
LensesValue >> gtDisplayOn: stream [

	self value gtDisplayOn: stream
]

{ #category : #accessing }
LensesValue >> hasValue [

	^ true
]

{ #category : #printing }
LensesValue >> printOn: aStream [

	super printOn: aStream.

	aStream
		nextPut: $(;
		print: self value;
		nextPut: $)
]

{ #category : #accessing }
LensesValue >> value [

	^ value
]

{ #category : #accessing }
LensesValue >> value: anObject [

	value := anObject
]
