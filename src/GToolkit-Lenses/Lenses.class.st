Class {
	#name : #Lenses,
	#superclass : #Object,
	#traits : 'TLenses + TLensesComposition',
	#classTraits : 'TLenses classTrait + TLensesComposition classTrait',
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

{ #category : #'api - lens composition' }
Lenses >> addLens: aLens [

	self lenses: (self lenses copyWith: aLens)
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
		  itemText: #gtHistoryStepItemDisplayText;
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
