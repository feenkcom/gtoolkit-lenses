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

{ #category : #reading }
LensesJsonReader >> readOn: aStream [

	| aWriter |
	aWriter := NeoJSONReader on: aStream.

	LensesJsonUtility commonMappingsFor: aWriter.

	lenses := aWriter nextAs: LensesJsonMetaProperty.

	^ lenses
]