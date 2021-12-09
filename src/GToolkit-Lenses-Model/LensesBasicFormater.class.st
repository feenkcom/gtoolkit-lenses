Class {
	#name : #LensesBasicFormater,
	#superclass : #Object,
	#instVars : [
		'format'
	],
	#category : #'GToolkit-Lenses-Model-Support'
}

{ #category : #converting }
LensesBasicFormater >> asLensesFormater [

	^ self
]

{ #category : #accessing }
LensesBasicFormater >> format [

	^ format
]

{ #category : #accessing }
LensesBasicFormater >> format: anObject [

	format := anObject
]

{ #category : #printing }
LensesBasicFormater >> printOn: aStream [

	super printOn: aStream.

	self format ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self format asString;
		nextPut: $)
]

{ #category : #formating }
LensesBasicFormater >> value: aFirstValue value: aSecondValue [

	^ self format format: { 
			aFirstValue.
			aSecondValue }
]
