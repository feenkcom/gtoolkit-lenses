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

{ #category : #'gt - extensions' }
LensesTransformedJsonObject >> gtJsonParentFor: aView [

	<gtView>
	self parent ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'JSON Parent';
		  priority: 2;
		  object: [ self parent ];
		  view: #gtJsonFor:
]

{ #category : #accessing }
LensesTransformedJsonObject >> object [

	^ object
]

{ #category : #accessing }
LensesTransformedJsonObject >> object: anObject [

	object := anObject
]
