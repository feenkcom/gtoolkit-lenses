Class {
	#name : #LensesInLens,
	#superclass : #Object,
	#traits : 'TLenses + TLensesComposition',
	#classTraits : 'TLenses classTrait + TLensesComposition classTrait',
	#instVars : [
		'name',
		'lenses'
	],
	#category : #'GToolkit-Lenses-Lenses'
}

{ #category : #converting }
LensesInLens class >> jsonMappingV1Asociations [

	^ { 
		  ('name' -> nil).
		  ('lenses' -> { TLenses }) }
]

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

{ #category : #'gt - extensions' }
LensesInLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'In ' asRopedText.
	aName := LensesUtility styleKey: self name.

	aText append: aName.

	^ aText
]

{ #category : #'gt - extensions' }
LensesInLens >> gtLensesChildren [

	^ self lenses
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
