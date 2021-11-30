Trait {
	#name : #TLensesProperty,
	#category : #'GToolkit-Lenses-Properties'
}

{ #category : #visiting }
TLensesProperty >> accept: aVisitor [

	^ self explicitRequirement
]

{ #category : #'gt - extensions' }
TLensesProperty >> gtLensesChildren [

	^ #(  )
]
