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

{ #category : #converting }
LensesJson >> asOutput [

	^ self copy
]

{ #category : #execution }
LensesJson >> executor [

	^ LensesJsonExecutor new context:
		  (LensesInitialInput new input: self)
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

{ #category : #'gt - extensions' }
LensesJson >> gtLiveFor: aView [

	^ self gtJsonFor: aView
]

{ #category : #accessing }
LensesJson >> object [

	^ object
]

{ #category : #accessing }
LensesJson >> object: anObject [

	object := anObject
]
