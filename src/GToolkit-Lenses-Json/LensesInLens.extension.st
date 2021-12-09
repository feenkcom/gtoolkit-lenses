Extension { #name : #LensesInLens }

{ #category : #'*GToolkit-Lenses-Json' }
LensesInLens class >> jsonMappingV1Asociations [

	^ { 
		  ('name' -> nil).
		  ('lenses' -> { TLenses }) }
]
