Extension { #name : #LensesHoistLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesHoistLens >> gtHistoryStepItemDisplayText [

	| aText aName aHost |
	self name ifNil: [ ^ self gtDisplayString ].
	self host ifNil: [ ^ self gtDisplayString ].

	aText := 'Hoist ' asRopedText.
	aName := LensesWidgetUtility styleKey: self name.
	aHost := LensesWidgetUtility styleKey: self host.

	aText
		append: aName;
		append: ' from ' asRopedText;
		append: aHost.

	^ aText
]
