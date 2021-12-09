Extension { #name : #LensesBasicFormater }

{ #category : #'*GToolkit-Lenses-Json' }
LensesBasicFormater class >> jsonMappingV1Name [

	"Use a default name computed by {{gtMethod:LensesJsonUtility class>>#jsonMappingV1PropertyNameFor:}}"

	<lensesModelTypes>
	^ LensesJsonUtility jsonMappingV1PropertyNameFor: self
]
