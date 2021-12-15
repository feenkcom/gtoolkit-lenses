Class {
	#name : #LensesRemoveLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name',
		'defaultValue'
	],
	#category : #'GToolkit-Lenses-Model-Lenses'
}

{ #category : #visiting }
LensesRemoveLens >> accept: aVisitor [

	^ aVisitor visitLensesRemoveLens: self
]

{ #category : #accessing }
LensesRemoveLens >> defaultValue [

	defaultValue ifNil: [ defaultValue := LensesNoValue uniqueInstance ].

	^ defaultValue value
]

{ #category : #accessing }
LensesRemoveLens >> defaultValue: anObject [

	defaultValue := LensesValue value: anObject
]

{ #category : #printing }
LensesRemoveLens >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Remove ';
		nextPutAll: self name asString
]

{ #category : #initialization }
LensesRemoveLens >> initialize [

	super initialize.

	defaultValue := LensesNoValue uniqueInstance
]

{ #category : #accessing }
LensesRemoveLens >> name [

	^ name
]

{ #category : #accessing }
LensesRemoveLens >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesRemoveLens >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPut: $)
]

{ #category : #'api - lenses' }
LensesRemoveLens >> reversed [

	"Return lenses for reversed transformation"

	^ LensesAddLens new
		name: self name;
		value: self defaultValue
]
