Class {
	#name : #LensesJsonWriter,
	#superclass : #Object,
	#instVars : [
		'lenses',
		'prettyPrint'
	],
	#category : #'GToolkit-Lenses-JSON Converter'
}

{ #category : #accessing }
LensesJsonWriter >> lenses [

	^ lenses
]

{ #category : #accessing }
LensesJsonWriter >> lenses: anObject [

	lenses := anObject
]

{ #category : #accessing }
LensesJsonWriter >> prettyPrint [

	^ prettyPrint ifNil: [ true ]
]

{ #category : #accessing }
LensesJsonWriter >> prettyPrint: aBoolean [

	prettyPrint := aBoolean
]

{ #category : #writing }
LensesJsonWriter >> write [

	^ String streamContents: [ :aStream | self writeOn: aStream ]
]

{ #category : #writing }
LensesJsonWriter >> writeOn: aStream [

	| aWriter |
	aWriter := NeoJSONWriter on: aStream.
	aWriter prettyPrint: self prettyPrint.

	"define mappings"
	TLensesProperty users do: [ :eachUser | 
		eachUser isClass ifTrue: [ 
			eachUser instanceSide jsonMappingV1On: aWriter ] ].

	^ aWriter nextPut: self lenses
]
