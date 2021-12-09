Extension { #name : #LensesHeadLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesHeadLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'Head in ' asRopedText.
	aName := LensesWidgetUtility styleKey: self name.

	aText append: aName.

	^ aText
]
