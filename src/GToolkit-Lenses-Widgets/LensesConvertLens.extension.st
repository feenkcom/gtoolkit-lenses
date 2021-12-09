Extension { #name : #LensesConvertLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesConvertLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'Convert ' asRopedText.
	aName := LensesWidgetUtility styleKey: self name.

	aText append: aName.

	^ aText
]
