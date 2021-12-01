Class {
	#name : #LensesInitialJsonObject,
	#superclass : #Object,
	#traits : 'TLensesJsonObjectAccess',
	#classTraits : 'TLensesJsonObjectAccess classTrait',
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Lenses-Inputs'
}

{ #category : #'api - instance creation' }
LensesInitialJsonObject class >> forObject: anObject [

	^ self new object: anObject
]

{ #category : #execution }
LensesInitialJsonObject >> executor [

	^ LensesJsonExecutor new step: (LensesInitialStep new input: self)
]

{ #category : #accessing }
LensesInitialJsonObject >> object [

	^ object
]

{ #category : #accessing }
LensesInitialJsonObject >> object: anObject [

	object := anObject
]
