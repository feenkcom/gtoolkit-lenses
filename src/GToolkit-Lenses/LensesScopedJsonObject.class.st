Class {
	#name : #LensesScopedJsonObject,
	#superclass : #Object,
	#traits : 'TLensesJsonObjectAccess',
	#classTraits : 'TLensesJsonObjectAccess classTrait',
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Lenses-Inputs'
}

{ #category : #'gt - extensions' }
LensesScopedJsonObject >> gtJsonParentFor: aView [

	<gtView>
	self parent ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'JSON Parent';
		  priority: 2;
		  object: [ self parent ];
		  view: #gtJsonFor:
]

{ #category : #accessing }
LensesScopedJsonObject >> object [

	^ object
]

{ #category : #accessing }
LensesScopedJsonObject >> object: anObject [

	object := anObject
]
