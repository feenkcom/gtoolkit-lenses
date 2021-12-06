Class {
	#name : #LensesTransformedJsonObject,
	#superclass : #Object,
	#traits : 'TLensesJsonObjectAccess',
	#classTraits : 'TLensesJsonObjectAccess classTrait',
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Lenses-Inputs'
}

{ #category : #accessing }
LensesTransformedJsonObject >> object [

	^ object
]

{ #category : #accessing }
LensesTransformedJsonObject >> object: anObject [

	object := anObject
]
