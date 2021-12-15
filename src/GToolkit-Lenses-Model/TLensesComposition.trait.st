Trait {
	#name : #TLensesComposition,
	#category : #'GToolkit-Lenses-Model-Lenses'
}

{ #category : #'api - lens composition' }
TLensesComposition >> add: aName value: aValue [

	self addLens: (LensesAddLens new
			 name: aName;
			 value: aValue)
]

{ #category : #'api - lens composition' }
TLensesComposition >> addLens: aLens [

	self explicitRequirement
]

{ #category : #'api - lens composition' }
TLensesComposition >> hoist: aName from: aHost [

	self addLens: (LensesHoistLens new name: aName; host: aHost)
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
TLensesComposition >> remove: aName defaultValue: aValue [

	self addLens: (LensesRemoveLens new
			 name: aName;
			 defaultValue: aValue)
]

{ #category : #'api - lens composition' }
TLensesComposition >> rename: anOldName to: aNewName [

	self addLens: (LensesRenameLens new source: anOldName; destination: aNewName)
]

{ #category : #'api - lens composition' }
TLensesComposition >> split: aFirstName destination: aSecondName regex: aRegex [

	self addLens: (LensesSplitLens new
			 name: aFirstName;
			 destination: aSecondName;
			 splitter: (LensesRegexSplitter forString: aRegex))
]

{ #category : #'api - lens composition' }
TLensesComposition >> split: aFirstName destination: aSecondName regex: aRegex mergeFormat: aMergeFormat [

	self addLens: (LensesSplitLens new
			 name: aFirstName;
			 destination: aSecondName;
			 splitter: (LensesRegexSplitter forString: aRegex);
			 mergeFormat: aMergeFormat)
]

{ #category : #'api - lens composition' }
TLensesComposition >> split: aFirstName destinations: aCollectionOfNames regex: aRegex [

	self addLens: (LensesSplitLens new
			 name: aFirstName;
			 destinations: aCollectionOfNames;
			 splitter: (LensesRegexSplitter forString: aRegex))
]
