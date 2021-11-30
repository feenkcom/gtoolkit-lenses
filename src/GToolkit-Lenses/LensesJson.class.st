Class {
	#name : #LensesJson,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Lenses-Inputs'
}

{ #category : #'api - instance creation' }
LensesJson class >> forObject: anObject [

	^ self new object: anObject
]

{ #category : #execution }
LensesJson >> executor [

	^ LensesJsonExecutor new input: self; output: self copy
]

{ #category : #'gt - extensions' }
LensesJson >> gtJsonFor: aView [

	<gtView>
	self object ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'JSON';
		  priority: 1;
		  object: [ self object ];
		  view: #gtTreeFor:
]

{ #category : #accessing }
LensesJson >> object [

	^ object
]

{ #category : #accessing }
LensesJson >> object: anObject [

	object := anObject
]
