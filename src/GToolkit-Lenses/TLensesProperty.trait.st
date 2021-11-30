Trait {
	#name : #TLensesProperty,
	#category : #'GToolkit-Lenses-Properties'
}

{ #category : #accessing }
TLensesProperty >> accept: aVisitor [

	^ self explicitRequirement
]
