Class {
	#name : #Lenses,
	#superclass : #Object,
	#traits : 'TLensesProperty',
	#classTraits : 'TLensesProperty classTrait',
	#instVars : [
		'name',
		'lenses'
	],
	#category : #'GToolkit-Lenses-Core'
}

{ #category : #visiting }
Lenses >> accept: aVisitor [

	^ aVisitor visitLenses: self
]

{ #category : #execution }
Lenses >> execute: anInput [

	^ self executor
		  input: anInput;
		  execute
]

{ #category : #execution }
Lenses >> executor [

	^ LensesExecutor new lenses: self
]

{ #category : #'gt - extensions' }
Lenses >> gtLensesFor: aView [

	<gtView>
	^ aView tree
		  title: 'Lenses';
		  items: [ self lenses ];
		  children: [ :aProperty | aProperty gtLensesChildren ];
		  expandAll
]

{ #category : #accessing }
Lenses >> lenses [

	^ lenses ifNil: [ #() ]
]

{ #category : #accessing }
Lenses >> lenses: anObject [

	lenses := anObject
]

{ #category : #accessing }
Lenses >> name [

	^ name ifNil: [ '' ]
]

{ #category : #accessing }
Lenses >> name: anObject [

	name := anObject
]

{ #category : #execution }
Lenses >> transform: anInput [

	^ (self execute: anInput) output
]
