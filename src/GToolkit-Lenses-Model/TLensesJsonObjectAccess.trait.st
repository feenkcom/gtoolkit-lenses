Trait {
	#name : #TLensesJsonObjectAccess,
	#category : #'GToolkit-Lenses-Model-Inputs'
}

{ #category : #converting }
TLensesJsonObjectAccess >> asFollowingOutput [

	| aCopy |
	aCopy := self object isCollection
		         ifTrue: [ self object collect: #copy ]
		         ifFalse: [ self object copy ].

	^ LensesTransformedJsonObject new object: aCopy
]

{ #category : #converting }
TLensesJsonObjectAccess >> asLensesInput [

	^ self
]

{ #category : #'api - json' }
TLensesJsonObjectAccess >> at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [

	self object isDictionary ifTrue: [ 
		self object
			at: aKey
			ifPresent: [ :aValue | 
				aPresentBlock cull: aValue cull: self object ]
			ifAbsent: [ 
				anAbsentBlock cull: self object ].
		^ self ].

	self object isArray ifTrue: [ 
		self object do: [ :eachObject | 
			eachObject
				at: aKey
				ifPresent: [ :aValue | 
					aPresentBlock cull: aValue cull: eachObject ]
				ifAbsent: [ 
					anAbsentBlock cull: eachObject ] ].
		^ self ].

	self error:
		('Unknown JSON object: {1}' format: self object printString)
]

{ #category : #'api - json' }
TLensesJsonObjectAccess >> at: aKey put: aValue [

	self object isDictionary ifTrue: [ 
		self object at: aKey put: aValue.
		^ self ].

	self object isArray ifTrue: [ 
		self object do: [ :eachObject | eachObject at: aKey put: aValue ].
		^ self ].

	self error:
		('Unknown JSON object: {1}' format: self object printString)
]

{ #category : #'api - json' }
TLensesJsonObjectAccess >> object [

	^ self explicitRequirement
]

{ #category : #'api - json' }
TLensesJsonObjectAccess >> removeKey: aKey [

	self object isDictionary ifTrue: [ 
		self object removeKey: aKey.
		^ self ].

	self object isArray ifTrue: [ 
		self object do: [ :eachObject | eachObject removeKey: aKey ].
		^ self ].

	self error:
		('Unknown JSON object: {1}' format: self object printString)
]
