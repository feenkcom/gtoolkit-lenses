Extension { #name : #Collection }

{ #category : #'*GToolkit-Lenses-Model' }
Collection >> asLensesInput [

	^ LensesInitialJsonObject forObject: self
]
