Extension { #name : #LensesAddLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesAddLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'At ' asRopedText.
	aName := LensesWidgetUtility styleKey: self name.

	aText append: aName.
	aText append: ' put ' asRopedText.
	aText append: self value asRopedText italic.

	^ aText
]
