Extension { #name : #LensesInLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesInLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'In ' asRopedText.
	aName := LensesWidgetUtility styleKey: self name.

	aText append: aName.

	^ aText
]

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesInLens >> gtLensesChildren [

	^ self lenses
]
