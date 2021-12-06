Trait {
	#name : #TLenses,
	#category : #'GToolkit-Lenses-Lenses'
}

{ #category : #converting }
TLenses classSide >> jsonMappingV1Asociations [

	"Return a collection of 'instance variable name' -> 'schema name'.
	Instance variable name is a string.
	Schema name is a class or nil."

	^ nil
]

{ #category : #converting }
TLenses classSide >> jsonMappingV1Name [
	"Use a default name computed by {{gtMethod:LensesJsonUtility class>>#jsonMappingV1PropertyNameFor:}}"

	^ nil
]

{ #category : #converting }
TLenses classSide >> jsonMappingV1On: aNeoJSONMapper [

	LensesJsonUtility jsonMappingV1For: self on: aNeoJSONMapper
]

{ #category : #converting }
TLenses classSide >> neoJsonMapping: aNeoJSONMapper [

	self jsonMappingV1On: aNeoJSONMapper
]

{ #category : #visiting }
TLenses >> accept: aVisitor [

	^ self explicitRequirement
]

{ #category : #converting }
TLenses >> asJsonString [

	^ LensesJsonWriter new
		  lenses: (LensesJsonMetaProperty new property: self);
		  write
]

{ #category : #'gt - extensions' }
TLenses >> gtHistoryStepItemDisplayText [

	^ self gtDisplayString
]

{ #category : #'gt - extensions' }
TLenses >> gtLensesChildren [

	^ #(  )
]

{ #category : #'api - property' }
TLenses >> nextStepFrom: aPreviousStep [

	^ LensesTransformationStep new
		  previousStep: aPreviousStep;
		  lens: self;
		  input: aPreviousStep output.
]
