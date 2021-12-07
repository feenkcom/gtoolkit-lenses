Extension { #name : #String }

{ #category : #'*GToolkit-Lenses' }
String >> asLensesFormater [

	^ LensesBasicFormater new format: self
]

{ #category : #'*GToolkit-Lenses' }
String >> asLensesInput [

	^ LensesInitialJsonObject fromString: self
]
