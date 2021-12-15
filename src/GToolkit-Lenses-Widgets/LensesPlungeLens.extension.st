Extension { #name : #LensesPlungeLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesPlungeLens >> gtHistoryStepItemDisplayText [

	| aText aName aHost |
	self name ifNil: [ ^ self gtDisplayString ].
	self host ifNil: [ ^ self gtDisplayString ].

	aText := 'Plunge ' asRopedText.
	aName := LensesWidgetUtility styleKey: self name.
	aHost := LensesWidgetUtility styleKey: self host.

	aText
		append: aName;
		append: ' into ' asRopedText;
		append: aHost.

	^ aText
]
