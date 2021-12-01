Extension { #name : #String }

{ #category : #'*GToolkit-Lenses' }
String >> asLensesInput [

	^ LensesInitialJsonObject fromString: self
]
