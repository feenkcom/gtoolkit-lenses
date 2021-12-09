Extension { #name : #LensesRemoveLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesRemoveLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'Remove ' asRopedText.
	aName := LensesWidgetUtility styleKey: self name.

	aText append: aName.

	^ aText
]
