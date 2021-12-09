Class {
	#name : #LensesJsonUtility,
	#superclass : #Object,
	#category : #'GToolkit-Lenses-Json-Utilities'
}

{ #category : #'api - json' }
LensesJsonUtility class >> commonMappingsFor: aMapper [

	aMapper for: LensesJsonMetaObject customDo: [ :mapping | 
		mapping writer: [ :aWriter :aMeta | 
			self writeMeta: aMeta on: aWriter ].
		mapping reader: [ :aReader | self parseMetaOn: aReader ] ].

	aMapper for: LensesJsonMetaCollection customDo: [ :mapping | 
		mapping writer: [ :aWriter :aCollection | 
			self writePropertyCollection: aCollection on: aWriter ].
		mapping reader: [ :aReader | 
			self parsePropertyCollectionOn: aReader ] ].

	LensesJsonTypes objectModelTypes keysAndValuesDo: [ :aName :aClass | 
		(aClass respondsTo: #jsonMappingV1On:)
			ifTrue: [ aClass jsonMappingV1On: aMapper ]
			ifFalse: [ LensesJsonUtility jsonMappingV1For: aClass on: aMapper ] ].
]

{ #category : #'api - json' }
LensesJsonUtility class >> jsonMappingV1AssociationsFor: aPropertyClass [

	^ aPropertyClass instanceVariables collect: [ :eachInsVar | 
		  eachInsVar name -> nil ]
]

{ #category : #'api - json' }
LensesJsonUtility class >> jsonMappingV1For: aPropertyClass on: aNeoJSONMapper [

	| aName aPropertyValues |
	aName := aPropertyClass jsonMappingV1Name ifNil: [ 
		         self jsonMappingV1PropertyNameFor: aPropertyClass ].
	aPropertyValues := (aPropertyClass respondsTo:
		                    #jsonMappingV1Asociations)
		                   ifTrue: [ 
		                   aPropertyClass jsonMappingV1Asociations ]
		                   ifFalse: [ 
		                   self jsonMappingV1AssociationsFor: aPropertyClass ].

	aNeoJSONMapper for: aPropertyClass customDo: [ :mapping | 
		mapping
			writer: [ :aWriter :aProperty | 
				self writeProperty: aProperty values: aPropertyValues on: aWriter ];
			reader: [ :aReader | 
				self
					parseProperty: aPropertyClass
					values: aPropertyValues
					on: aReader ] ]
]

{ #category : #'api - json' }
LensesJsonUtility class >> jsonMappingV1PropertyNameFor: aPropertyClass [

	| aName |
	aName := aPropertyClass name.
	(aName beginsWith: 'Lenses') ifTrue: [ 
		aName := aName last: aName size - 6 ].
	(aName endsWith: 'Lens') ifTrue: [ 
		aName := aName first: aName size - 4 ].
	aName := aName ifEmpty: [ aPropertyClass name ].
	^ aName asLowercase
]

{ #category : #'private - json' }
LensesJsonUtility class >> parseMetaOn: aReader [

	| aLenseType aClass aLens |
	aReader parseMapKeysDo: [ :aKey | 
		aKey = 'type' ifTrue: [ 
			aLenseType := aReader parseValue.
			aClass := LensesJsonTypes classOfJsonName: aLenseType ].
		aKey = 'object' ifTrue: [ 
			aClass ifNil: [ 
				self error: 'Type key must be defined first, then a content' ].
			aLens := aReader nextAs: aClass ] ].

	aLens ifNil: [ self error: 'Could not parse meta lens' ].

	^ aLens
]

{ #category : #'private - json' }
LensesJsonUtility class >> parseProperty: aPropertyClass values: aPropertyValues on: aReader [

	| aProperty |
	aProperty := aPropertyClass new.
	aReader parseMapKeysDo: [ :aKey | 
		| anAssoc aValueSchema aValue |
		anAssoc := aPropertyValues
			           detect: [ :eachAssoc | eachAssoc key = aKey ]
			           ifNone: [ 
				           self error:
					           ('Unknown property {1} is not included in {2}' 
						            format: { 
								            aKey.
								            (aPropertyValues collect: #key) }) ].

		aValue := LensesJsonUtility parsePropertyField: anAssoc on: aReader.
		aProperty perform: anAssoc key asSymbol asMutator with: aValue ].
	^ aProperty
]

{ #category : #'private - json' }
LensesJsonUtility class >> parsePropertyCollectionOn: aReader [

	^ aReader nextListAs: LensesJsonMetaObject
]

{ #category : #'private - json' }
LensesJsonUtility class >> parsePropertyField: anAssoc on: aReader [

	"anAssoc can be:
		'name' -> nil            ...indicating a simple value type
		'lens' -> TLenses        ...indicating a property type 
		'lenses' -> { TLenses }  ...indicating a collection of properties 
	"

	| aValueSchema aValueName |
	aValueName := anAssoc key asSymbol.
	aValueSchema := anAssoc value.

	aValueSchema ifNil: [ ^ aReader next ].

	aValueSchema isCollection ifTrue: [ 
		^ aReader nextAs: LensesJsonMetaCollection ].

	aValueSchema isClass ifTrue: [ 
		^ aReader nextAs: LensesJsonMetaObject ].

	self error: ('Unknown "{1}" field schema: {2}' format: { 
				 aValueName.
				 aValueSchema })
]

{ #category : #'private - json' }
LensesJsonUtility class >> writeMeta: aMeta on: aWriter [

	aWriter writeMapStreamingDo: [ :mapWriter | 
		| aType |
		aType := aMeta type ifNil: [ 
			         self jsonMappingV1PropertyNameFor: aMeta object class ].
		mapWriter writeKey: 'type' value: aType.
		mapWriter writeKey: 'object' value: aMeta object ]
]

{ #category : #'private - json' }
LensesJsonUtility class >> writeProperty: aProperty field: anAssoc on: mapWriter [

	"anAssoc can be:
		'name' -> nil            ...indicating a simple value type
		'lens' -> TLenses        ...indicating a property type 
		'lenses' -> { TLenses }  ...indicating a collection of properties 
	"

	| aValueSchema aValueName |
	aValueName := anAssoc key asSymbol.
	aValueSchema := anAssoc value.

	aValueSchema ifNil: [ 
		mapWriter
			writeKey: aValueName
			value: (aProperty perform: aValueName).
		^ self ].

	aValueSchema isCollection ifTrue: [ 
		mapWriter
			writeKey: aValueName
			value: (aProperty perform: aValueName)
			as: LensesJsonMetaCollection.
		^ self ].

	aValueSchema isClassOrTrait ifTrue: [ 
		mapWriter
			writeKey: aValueName
			value:
			(LensesJsonMetaObject new object:
				 (aProperty perform: aValueName)).
		^ self ].

	self error: ('Unknown "{1}" field schema: {2}' format: { 
				 aValueName.
				 aValueSchema })
]

{ #category : #'private - json' }
LensesJsonUtility class >> writeProperty: aProperty values: aPropertyValues on: aWriter [

	aWriter writeMapStreamingDo: [ :mapWriter | 
		aPropertyValues do: [ :eachAssoc | 
			self writeProperty: aProperty field: eachAssoc on: mapWriter ] ]
]

{ #category : #'private - json' }
LensesJsonUtility class >> writePropertyCollection: aCollection on: aWriter [

	aWriter writeListStreamingDo: [ :jsonListWriter | 
		aCollection do: [ :each | 
			jsonListWriter writeElement:
				(LensesJsonMetaObject new object: each) ] ]
]
