Extension { #name : #LensesRenameLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesRenameLens >> gtHistoryStepItemDisplayText [

	| aText aSource aDestination |
	self source ifNil: [ ^ self gtDisplayString ].
	self destination ifNil: [ ^ self gtDisplayString ].

	aText := 'Rename ' asRopedText.
	aSource := LensesWidgetUtility styleKey: self source.
	aDestination := LensesWidgetUtility styleKey: self destination.

	aText
		append: aSource;
		append: ' to ' asRopedText;
		append: aDestination.

	^ aText
]
