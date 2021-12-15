Class {
	#name : #Lenses,
	#superclass : #Object,
	#traits : 'TLenses + TLensesComposition',
	#classTraits : 'TLenses classTrait + TLensesComposition classTrait',
	#instVars : [
		'schemaName',
		'lenses'
	],
	#category : #'GToolkit-Lenses-Model-Core'
}

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

{ #category : #'api - lenses' }
Lenses >> reversed [

	"Return lenses for reversed transformation"

	^ self class new
		  schemaName: self schemaName;
		  lenses: (self lenses collect: #reversed) reversed
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
