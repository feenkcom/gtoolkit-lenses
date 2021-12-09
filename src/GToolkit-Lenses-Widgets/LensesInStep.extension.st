Extension { #name : #LensesInStep }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesInStep >> gtHistoryStepChildren [

	^ self children ifNil: [ #(  ) ]
]

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesInStep >> gtHistoryStepItemDisplayText [

	self lens ifNil: [ ^ self gtDisplayString ].

	^ self lens gtHistoryStepItemDisplayText
]
