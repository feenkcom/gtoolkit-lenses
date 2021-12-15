Class {
	#name : #LensesNoValue,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Lenses-Model-Support'
}

{ #category : #cleanup }
LensesNoValue class >> cleanUp [

	uniqueInstance := nil
]

{ #category : #accessing }
LensesNoValue class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #printing }
LensesNoValue >> gtDisplayOn: stream [

	stream nextPutAll: 'undefined'
]

{ #category : #testing }
LensesNoValue >> hasValue [

	^ false
]

{ #category : #accessing }
LensesNoValue >> value [

	^ self error: 'Default value is not defined.'
]
