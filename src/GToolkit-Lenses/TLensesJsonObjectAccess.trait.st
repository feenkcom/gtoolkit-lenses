Trait {
	#name : #TLensesJsonObjectAccess,
	#category : #'GToolkit-Lenses-Inputs'
}

{ #category : #converting }
TLensesJsonObjectAccess >> asFollowingOutput [

	^ LensesTransformedJsonObject new object: self object copy
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
			ifPresent: aPresentBlock
			ifAbsent: anAbsentBlock.
		^ self ].

	self object isArray ifTrue: [ 
		self object do: [ :eachObject | 
			eachObject
				at: aKey
				ifPresent: aPresentBlock
				ifAbsent: anAbsentBlock ].
		^ self ].
	
	self error: ('Unknown JSON object: {1}' format: self object printString)
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

{ #category : #'gt - extensions' }
TLensesJsonObjectAccess >> gtJsonFor: aView context: aContext [

	<gtView>
	self object ifNil: [ ^ aView empty ].

	aContext at: #gtTreeExpansionLevel ifAbsentPut: [ true ].

	^ aView forward
		  title: 'JSON';
		  priority: 1;
		  object: [ self object ];
		  view: #gtTreeFor:context:
]

{ #category : #'gt - extensions' }
TLensesJsonObjectAccess >> gtLiveFor: aView [

	^ aView forward
		  title: 'JSON';
		  priority: 1;
		  object: [ self ];
		  view: #gtJsonFor:context:
]

{ #category : #'gt - extensions' }
TLensesJsonObjectAccess >> gtTextFor: aView [

	<gtView>
	self object ifNil: [ ^ aView empty ].

	^ aView textEditor
		  title: 'JSON (Text)';
		  priority: 2;
		  aptitude: [ BrGlamorousCodeEditorAptitude ];
		  styler: [ JSONParser gtStyler ];
		  text: [ STONJSON toStringPretty: self object ]
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
