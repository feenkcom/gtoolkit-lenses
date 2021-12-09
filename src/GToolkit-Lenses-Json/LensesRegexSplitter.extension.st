Extension { #name : #LensesRegexSplitter }

{ #category : #'*GToolkit-Lenses-Json' }
LensesRegexSplitter class >> jsonMappingV1Name [

	"Use a default name computed by {{gtMethod:LensesJsonUtility class>>#jsonMappingV1PropertyNameFor:}}"

	<lensesModelTypes>
	^ LensesJsonUtility jsonMappingV1PropertyNameFor: self
]
