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

{ #category : #'api - property' }
TLensesProperty >> nextStepFrom: aPreviousStep [

	^ LensesTransformationStep new
		  previousStep: aPreviousStep;
		  property: self
]
