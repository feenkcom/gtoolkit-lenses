Class {
	#name : #Lenses,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'schemaName',
		'lenses'
	],
	#category : #'GToolkit-Lenses-Core'
}

{ #category : #converting }
Lenses class >> jsonMappingV1Asociations [

	^ { 
		  ('schemaName' -> nil).
		  ('lenses' -> { TLenses }) }
]

{ #category : #visiting }
Lenses >> accept: aVisitor [

	^ aVisitor visitLenses: self
]

{ #category : #accessing }
Lenses >> asJsonObject [
]

{ #category : #execution }
Lenses >> execute: anInput [

	^ anInput asLensesInput executor
		  lenses: self;
		  execute;
		  step
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

	^ self schemaName ifNil: [ '' ]
]

{ #category : #accessing }
Lenses >> name: aString [

	self schemaName: aString
]

{ #category : #accessing }
Lenses >> schemaName [

	^ schemaName
]

{ #category : #accessing }
Lenses >> schemaName: aString [

	schemaName := aString
]

{ #category : #execution }
Lenses >> transform: anInput [

	^ (self execute: anInput) output
]
