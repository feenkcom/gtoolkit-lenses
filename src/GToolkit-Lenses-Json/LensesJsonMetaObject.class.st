Class {
	#name : #LensesJsonMetaObject,
	#superclass : #Object,
	#instVars : [
		'type',
		'object'
	],
	#category : #'GToolkit-Lenses-Json-Support'
}

{ #category : #accessing }
LensesJsonMetaObject >> object [

	^ object
]

{ #category : #converting }
LensesJsonMetaObject >> object: anObject [

	object := anObject
]

{ #category : #accessing }
LensesJsonMetaObject >> type [

	^ type
]

{ #category : #accessing }
LensesJsonMetaObject >> type: anObject [

	type := anObject
]
