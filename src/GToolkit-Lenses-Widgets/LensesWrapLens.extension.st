Extension { #name : #LensesWrapLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesWrapLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'Wrap ' asRopedText.
	aName := LensesWidgetUtility styleKey: self name.

	aText append: aName.

	^ aText
]
