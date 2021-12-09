Extension { #name : #LensesMergeLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesMergeLens >> gtHistoryStepItemDisplayText [

	| aText aFirstName aSecondName |
	self firstName ifNil: [ ^ self gtDisplayString ].

	aText := 'Merge ' asRopedText.
	aFirstName := LensesWidgetUtility styleKey: self firstName.
	aSecondName := LensesWidgetUtility styleKey: self secondName.

	aText
		append: aFirstName;
		append: ' and ' asRopedText;
		append: aSecondName.

	^ aText
]
