Class {
	#name : #LensesInLens,
	#superclass : #Object,
	#traits : 'TLenses + TLensesComposition',
	#classTraits : 'TLenses classTrait + TLensesComposition classTrait',
	#instVars : [
		'name',
		'lenses'
	],
	#category : #'GToolkit-Lenses-Model-Lenses'
}

{ #category : #visiting }
LensesInLens >> accept: aVisitor [

	^ aVisitor visitLensesInLens: self
]

{ #category : #'api - lens composition' }
LensesInLens >> addLens: aLens [

	self lenses: (self lenses copyWith: aLens)
]

{ #category : #printing }
LensesInLens >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'In ';
		nextPutAll: self name asString
]

{ #category : #accessing }
LensesInLens >> lenses [

	^ lenses ifNil: [ #(  ) ]
]

{ #category : #accessing }
LensesInLens >> lenses: anObject [

	lenses := anObject
]

{ #category : #accessing }
LensesInLens >> name [

	^ name
]

{ #category : #accessing }
LensesInLens >> name: anObject [

	name := anObject
]

{ #category : #'api - lenses' }
LensesInLens >> nextStepFrom: aPreviousStep [

	^ LensesInStep new
		  previousStep: aPreviousStep;
		  lens: self;
		  input: aPreviousStep output
]

{ #category : #printing }
LensesInLens >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPut: $)
]

{ #category : #'api - lenses' }
LensesInLens >> reversed [

	"Return lenses for reversed transformation"

	^ self class new
		  name: self name;
		  lenses: (self lenses collect: #reversed) reversed
]
