Class {
	#name : #LensesSplitLens,
	#superclass : #Object,
	#traits : 'TLenses',
	#classTraits : 'TLenses classTrait',
	#instVars : [
		'name',
		'destinations',
		'splitter',
		'mergeFormat'
	],
	#category : #'GToolkit-Lenses-Model-Lenses'
}

{ #category : #visiting }
LensesSplitLens >> accept: aVisitor [

	^ aVisitor visitLensesSplitLens: self
]

{ #category : #accessing }
LensesSplitLens >> allDestinations [

	^ Array with: self name withAll: self destinations
]

{ #category : #accessing }
LensesSplitLens >> destination: aString [

	self destinations: { aString }
]

{ #category : #accessing }
LensesSplitLens >> destinations [

	^ destinations
]

{ #category : #accessing }
LensesSplitLens >> destinations: anObject [

	destinations := anObject
]

{ #category : #printing }
LensesSplitLens >> gtDisplayOn: aStream [

	self name ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	aStream
		nextPutAll: 'Split ';
		nextPutAll: self name asString
]

{ #category : #initialization }
LensesSplitLens >> initialize [

	super initialize.

	mergeFormat := LensesNoValue uniqueInstance
]

{ #category : #accessing }
LensesSplitLens >> mergeFormat [

	^ mergeFormat value
]

{ #category : #accessing }
LensesSplitLens >> mergeFormat: aFormat [

	mergeFormat := LensesValue value: aFormat
]

{ #category : #accessing }
LensesSplitLens >> name [

	^ name
]

{ #category : #accessing }
LensesSplitLens >> name: anObject [

	name := anObject
]

{ #category : #printing }
LensesSplitLens >> printOn: aStream [

	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPut: $)
]

{ #category : #'api - lenses' }
LensesSplitLens >> reversed [

	"Return lenses for reversed transformation.
	Notice that the merge format must be defined explicitly."

	^ LensesMergeLens new
		  firstName: self name;
		  secondName: self destinations first;
		  format: self mergeFormat
]

{ #category : #accessing }
LensesSplitLens >> splitter [

	^ splitter
]

{ #category : #accessing }
LensesSplitLens >> splitter: anObject [

	splitter := anObject
]
