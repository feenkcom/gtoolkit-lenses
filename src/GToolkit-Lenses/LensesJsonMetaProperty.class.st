Class {
	#name : #LensesJsonMetaProperty,
	#superclass : #Object,
	#instVars : [
		'type',
		'property'
	],
	#category : #'GToolkit-Lenses-JSON Converter'
}

{ #category : #accessing }
LensesJsonMetaProperty >> property [

	^ property
]

{ #category : #converting }
LensesJsonMetaProperty >> property: aProperty [

	property := aProperty
]

{ #category : #accessing }
LensesJsonMetaProperty >> type [

	^ type
]

{ #category : #accessing }
LensesJsonMetaProperty >> type: anObject [

	type := anObject
]
