Class {
	#name : #LensesJsonTypes,
	#superclass : #Object,
	#category : #'GToolkit-Lenses-Json-Support'
}

{ #category : #accessing }
LensesJsonTypes class >> classOfJsonName: aString [

	^ self objectModelTypes
		at: aString
		ifAbsent: [ self error: ('Unknown lense type: {1}' format: aString) ]
]

{ #category : #accessing }
LensesJsonTypes class >> objectModelTypeCollector [

	^ (PragmaCollector selectors: #( #lensesModelTypes )) reset
]

{ #category : #accessing }
LensesJsonTypes class >> objectModelTypes [

	| aDictionary |
	aDictionary := Dictionary new.
	self objectModelTypeCollector collected ifNotNil: [ :aCollection | 
		aCollection do: [ :eachPragma | 
			eachPragma methodClass instanceSide isClass ifTrue: [ 
				| aResult |
				aResult := eachPragma methodClass instanceSide perform:
					           eachPragma methodSelector.
				aDictionary at: aResult put: eachPragma methodClass instanceSide ].

			eachPragma methodClass instanceSide isTrait ifTrue: [ 
				eachPragma methodClass instanceSide users do: [ :eachUser | 
					eachUser isClass ifTrue: [ 
						| aResult |
						aResult := eachUser perform: eachPragma methodSelector.
						aDictionary at: aResult put: eachUser ] ] ] ] ].

	^ aDictionary
]
