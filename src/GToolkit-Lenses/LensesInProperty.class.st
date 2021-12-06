Class {
	#name : #LensesInProperty,
	#superclass : #Object,
	#traits : 'TLensesProperty',
	#classTraits : 'TLensesProperty classTrait',
	#instVars : [
		'name',
		'lenses'
	],
	#category : #'GToolkit-Lenses-Properties'
}

{ #category : #converting }
LensesInProperty class >> jsonMappingV1Asociations [

	^ { 
		  ('name' -> nil).
		  ('lenses' -> { TLensesProperty }) }
]

{ #category : #visiting }
LensesInProperty >> accept: aVisitor [

	^ aVisitor visitLensesInProperty: self
]

{ #category : #printing }
LensesInProperty >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'In ';
		nextPutAll: self name asString
]

{ #category : #'gt - extensions' }
LensesInProperty >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'In ' asRopedText.
	aName := LensesUtility styleKey: self name.

	aText append: aName.

	^ aText
]

{ #category : #'gt - extensions' }
LensesInProperty >> gtLensesChildren [

	^ self lenses
]

{ #category : #accessing }
LensesInProperty >> lenses [

	^ lenses ifNil: [ #(  ) ]
]

{ #category : #accessing }
LensesInProperty >> lenses: anObject [

	lenses := anObject
]

{ #category : #accessing }
LensesInProperty >> name [

	^ name
]

{ #category : #accessing }
LensesInProperty >> name: anObject [

	name := anObject
]

{ #category : #'api - property' }
LensesInProperty >> nextStepFrom: aPreviousStep [

	^ LensesInStep new
		  previousStep: aPreviousStep;
		  property: self;
		  input: aPreviousStep output
]

{ #category : #printing }
LensesInProperty >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPut: $)
]
