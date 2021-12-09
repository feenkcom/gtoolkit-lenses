Extension { #name : #TLenses }

{ #category : #'*GToolkit-Lenses-Json' }
TLenses >> asJsonString [

	^ LensesJsonWriter new
		  lenses: (LensesJsonMetaObject new object: self);
		  write
]

{ #category : #'*GToolkit-Lenses-Json' }
TLenses classSide >> jsonMappingV1Asociations [

	"Return a collection of 'instance variable name' -> 'schema name'.
	Instance variable name is a string.
	Schema name is a class or nil."

	^ LensesJsonUtility jsonMappingV1AssociationsFor: self
]

{ #category : #'*GToolkit-Lenses-Json' }
TLenses classSide >> jsonMappingV1Name [

	"Use a default name computed by {{gtMethod:LensesJsonUtility class>>#jsonMappingV1PropertyNameFor:}}"

	<lensesModelTypes>
	^ LensesJsonUtility jsonMappingV1PropertyNameFor: self
]

{ #category : #'*GToolkit-Lenses-Json' }
TLenses classSide >> jsonMappingV1On: aNeoJSONMapper [

	LensesJsonUtility jsonMappingV1For: self on: aNeoJSONMapper
]

{ #category : #'*GToolkit-Lenses-Json' }
TLenses classSide >> neoJsonMapping: aNeoJSONMapper [

	self jsonMappingV1On: aNeoJSONMapper
]
