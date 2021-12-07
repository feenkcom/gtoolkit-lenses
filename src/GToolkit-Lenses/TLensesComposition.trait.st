Trait {
	#name : #TLensesComposition,
	#category : #'GToolkit-Lenses-Lenses'
}

{ #category : #'api - lens composition' }
TLensesComposition >> addLens: aLens [

	self explicitRequirement
]

{ #category : #'api - lens composition' }
TLensesComposition >> merge: aFirstName and: aSecondName format: aFormater [

	self addLens: (LensesMergeLens new
			 firstName: aFirstName;
			 secondName: aSecondName;
			 format: aFormater)
]

{ #category : #'api - lens composition' }
TLensesComposition >> remove: aName [

	self addLens: (LensesRemoveLens new name: aName)
]

{ #category : #'api - lens composition' }
TLensesComposition >> rename: anOldName to: aNewName [

	self addLens: (LensesRenameLens new source: anOldName; destination: aNewName)
]
