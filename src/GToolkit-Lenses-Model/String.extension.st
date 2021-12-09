Extension { #name : #String }

{ #category : #'*GToolkit-Lenses-Model' }
String >> asLensesFormater [

	^ LensesBasicFormater new format: self
]

{ #category : #'*GToolkit-Lenses-Model' }
String >> asLensesInput [

	^ LensesInitialJsonObject fromString: self
]
