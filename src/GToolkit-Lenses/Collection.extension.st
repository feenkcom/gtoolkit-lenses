Extension { #name : #Collection }

{ #category : #'*GToolkit-Lenses' }
Collection >> asLensesInput [

	^ LensesInitialJsonObject forObject: self
]
