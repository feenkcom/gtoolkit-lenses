Trait {
	#name : #TLenses,
	#category : #'GToolkit-Lenses-Model-Lenses'
}

{ #category : #visiting }
TLenses >> accept: aVisitor [

	^ self explicitRequirement
]

{ #category : #'api - lenses' }
TLenses >> defaultValue [

	^ self error: 'Default value is not supported.'
]

{ #category : #'api - lenses' }
TLenses >> nextStepFrom: aPreviousStep [

	^ LensesTransformationStep new
		  previousStep: aPreviousStep;
		  lens: self;
		  input: aPreviousStep output.
]

{ #category : #'api - lenses' }
TLenses >> reversed [

	"Return lenses for reversed transformation"

	^ self explicitRequirement
]
