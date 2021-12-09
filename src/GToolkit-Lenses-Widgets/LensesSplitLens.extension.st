Extension { #name : #LensesSplitLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesSplitLens >> gtHistoryStepItemDisplayText [

	| aText aName aDestination |
	self name ifNil: [ ^ self gtDisplayString ].
	self destinations ifNil: [ ^ self gtDisplayString ].
	self destinations ifEmpty: [ ^ self gtDisplayString ].

	aText := 'Split ' asRopedText.
	aName := LensesWidgetUtility styleKey: self name.
	aDestination := LensesWidgetUtility styleKey: self destinations first.

	aText
		append: aName;
		append: ' part into ' asRopedText;
		append: aDestination.

	self destinations size > 1 ifTrue: [ aText append: '...' asRopedText ].

	^ aText
]
