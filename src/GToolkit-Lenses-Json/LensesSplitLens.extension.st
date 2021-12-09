Extension { #name : #LensesSplitLens }

{ #category : #'*GToolkit-Lenses-Json' }
LensesSplitLens class >> jsonMappingV1Asociations [

	"Return a collection of 'instance variable name' -> 'schema name'.
	Instance variable name is a string.
	Schema name is a class or nil."

	^ { 
		  ('name' -> nil).
		  ('destinations' -> nil).
		  ('splitter' -> LensesRegexSplitter) }
]
