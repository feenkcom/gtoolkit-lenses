Class {
	#name : #LensesChildJson,
	#superclass : #Object,
	#instVars : [
		'parent',
		'object'
	],
	#category : #'GToolkit-Lenses-Inputs'
}

{ #category : #converting }
LensesChildJson >> asOutput [

	^ self copy
]

{ #category : #'gt - extensions' }
LensesChildJson >> gtJsonFor: aView [

	<gtView>
	self object ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'JSON Child';
		  priority: 1;
		  object: [ self object ];
		  view: #gtTreeFor:
]

{ #category : #'gt - extensions' }
LensesChildJson >> gtJsonParentFor: aView [

	<gtView>
	self parent ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'JSON Parent';
		  priority: 2;
		  object: [ self parent ];
		  view: #gtJsonFor:
]

{ #category : #'gt - extensions' }
LensesChildJson >> gtLiveFor: aView [

	^ self gtJsonFor: aView
]

{ #category : #accessing }
LensesChildJson >> object [

	^ object
]

{ #category : #accessing }
LensesChildJson >> object: anObject [

	object := anObject
]

{ #category : #accessing }
LensesChildJson >> parent [

	^ parent
]

{ #category : #accessing }
LensesChildJson >> parent: anObject [

	parent := anObject
]
