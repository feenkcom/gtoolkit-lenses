Class {
	#name : #LensesScopedJsonObject,
	#superclass : #Object,
	#traits : 'TLensesJsonObjectAccess',
	#classTraits : 'TLensesJsonObjectAccess classTrait',
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Lenses-Model-Inputs'
}

{ #category : #accessing }
LensesScopedJsonObject >> object [

	^ object
]

{ #category : #accessing }
LensesScopedJsonObject >> object: anObject [

	object := anObject
]
