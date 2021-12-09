Extension { #name : #LensesTransformationStep }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesTransformationStep >> gtHistoryStepItemDisplayText [

	self lens ifNil: [ ^ self gtDisplayString ].

	^ self lens gtHistoryStepItemDisplayText
]
