Class {
	#name : #LensesJsonReader,
	#superclass : #Object,
	#instVars : [
		'lenses'
	],
	#category : #'GToolkit-Lenses-JSON Converter'
}

{ #category : #reading }
LensesJsonReader class >> fromString: aString [

	^ self new fromString: aString
]

{ #category : #reading }
LensesJsonReader >> fromString: aString [

	^ aString readStreamDo: [ :aStream | self readOn: aStream ]
]

{ #category : #accessing }
LensesJsonReader >> lenses [

	^ lenses
]

{ #category : #private }
LensesJsonReader >> readLensesRoot: aReader [

	| aLenseType aClass aLens |
	aReader parseMapKeysDo: [ :aKey | 
		aKey = 'type' ifTrue: [ 
			aLenseType := aReader parseValue.
			aClass := TLensesProperty users
				          detect: [ :eachClass | 
					          eachClass isClass and: [ 
						          eachClass jsonMappingV1Name = aLenseType ] ]
				          ifNone: [ 
				          self error: ('Unknown lense type: {1}' format: aKey) ] ].
		aKey = 'content' ifTrue: [ 
			self halt.
			aClass ifNil: [ 
				self error: 'Type key must be defined first, then a content' ].
			aLens := aReader nextAs: aLenseType , 'Content' ] ].

	aLens ifNil: [ self error: 'Could not parse root lens' ].
self halt.
	^ aLens
]

{ #category : #reading }
LensesJsonReader >> readOn: aStream [

	| aWriter |
	aWriter := NeoJSONReader on: aStream.

	LensesJsonUtility commonMappingsFor: aWriter.

	lenses := aWriter nextAs: LensesJsonMetaProperty.

	^ lenses
]
