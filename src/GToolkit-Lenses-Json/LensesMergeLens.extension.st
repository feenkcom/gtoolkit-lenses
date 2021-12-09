Extension { #name : #LensesMergeLens }

{ #category : #'*GToolkit-Lenses-Json' }
LensesMergeLens class >> jsonMappingV1Asociations [

	"Return a collection of 'instance variable name' -> 'schema name'.
	Instance variable name is a string.
	Schema name is a class or nil."

	^ { 
		  ('firstName' -> nil).
		  ('secondName' -> nil).
		  ('format' -> LensesBasicFormater ) }
]
