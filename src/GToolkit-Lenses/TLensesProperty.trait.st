Trait {
	#name : #TLensesProperty,
	#category : #'GToolkit-Lenses-Properties'
}

{ #category : #converting }
TLensesProperty classSide >> jsonMappingV10Asociations [

	"Return a collection of 'instance variable name' -> 'schema name'.
	Instance variable name is a string.
	Schema name is a class or nil."

	^ self instanceVariables collect: [ :eachInsVar | 
		  eachInsVar name -> nil ]
]

{ #category : #converting }
TLensesProperty classSide >> jsonMappingV10Name [

	| aName |
	aName := self name.
	(aName beginsWith: 'Lenses') ifTrue: [ 
		aName := aName last: aName size - 6 ].
	(aName endsWith: 'Property') ifTrue: [ 
		aName := aName first: aName size - 8 ].
	aName := aName ifEmpty: [ self name ].
	^ aName asLowercase
]

{ #category : #converting }
TLensesProperty classSide >> jsonMappingV1On: aNeoJSONMapper [

	| aName aContentSchema |
	aName := self jsonMappingV10Name.
	aContentSchema := aName , 'Content'.

	aNeoJSONMapper for: self do: [ :mapping | 
		| aProperty |
		mapping
			mapProperty: #type
			getter: [ :object | aName ]
			setter: [ :object :value | self halt ].

		aProperty := mapping
			             mapProperty: #content
			             getter: [ :anObject | anObject ]
			             setter: [ :object :value | self halt ].

		aProperty valueSchema: aContentSchema ].

	aNeoJSONMapper for: aContentSchema customDo: [ :mapping | 
		mapping
			writer: [ :jsonWriter :aProperty | 
				jsonWriter writeMapStreamingDo: [ :mapWriter | 
						aProperty class jsonMappingV10Asociations do: [ :eachAssoc | 
								| aValueName aValueSchema |
								aValueName := eachAssoc key asSymbol.
								aValueSchema := eachAssoc value.

								aValueSchema
									ifNil: [ 
										mapWriter
											writeKey: aValueName
											value: (aProperty perform: aValueName) ]
									ifNotNil: [ 
										mapWriter
											writeKey: aValueName
											value: (aProperty perform: aValueName)
											as: aValueSchema ] ] ] ];
			decoder: [ :aString | self halt ] ]
]

{ #category : #converting }
TLensesProperty classSide >> neoJsonMapping: aNeoJSONMapper [

	self jsonMappingV1On: aNeoJSONMapper
]

{ #category : #visiting }
TLensesProperty >> accept: aVisitor [

	^ self explicitRequirement
]

{ #category : #converting }
TLensesProperty >> asJSONString [

	^ LensesJsonWriter new
		  lenses: self;
		  write
]

{ #category : #'gt - extensions' }
TLensesProperty >> gtLensesChildren [

	^ #(  )
]

{ #category : #'api - property' }
TLensesProperty >> nextStepFrom: aPreviousStep [

	^ LensesTransformationStep new
		  previousStep: aPreviousStep;
		  property: self
]
