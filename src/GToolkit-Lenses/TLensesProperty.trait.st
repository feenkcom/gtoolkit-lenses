Trait {
	#name : #TLensesProperty,
	#category : #'GToolkit-Lenses-Properties'
}

{ #category : #converting }
TLensesProperty classSide >> jsonMappingV1Asociations [

	"Return a collection of 'instance variable name' -> 'schema name'.
	Instance variable name is a string.
	Schema name is a class or nil."

	^ nil
]

{ #category : #converting }
TLensesProperty classSide >> jsonMappingV1Name [
	"Use a default name computed by {{gtMethod:LensesJsonUtility class>>#jsonMappingV1PropertyNameFor:}}"

	^ nil
]

{ #category : #converting }
TLensesProperty classSide >> jsonMappingV1On: aNeoJSONMapper [

	LensesJsonUtility jsonMappingV1For: self on: aNeoJSONMapper
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
TLensesProperty >> asJsonString [

	^ LensesJsonWriter new
		  lenses: (LensesJsonMetaProperty new property: self);
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
