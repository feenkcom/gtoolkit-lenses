Trait {
	#name : #TLensesJsonObjectAccess,
	#category : #'GToolkit-Lenses-Inputs'
}

{ #category : #converting }
TLensesJsonObjectAccess >> asFollowingOutput [

	^ LensesTransformedJsonObject new object: self object copy
]

{ #category : #'api - json' }
TLensesJsonObjectAccess >> at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [

	self object at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #'api - json' }
TLensesJsonObjectAccess >> at: aKey put: aValue [

	self object at: aKey put: aValue
]

{ #category : #'gt - extensions' }
TLensesJsonObjectAccess >> gtJsonFor: aView [

	<gtView>
	self object ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'JSON';
		  priority: 1;
		  object: [ self object ];
		  view: #gtTreeFor:
]

{ #category : #'gt - extensions' }
TLensesJsonObjectAccess >> gtLiveFor: aView [

	^ self gtJsonFor: aView
]

{ #category : #'api - json' }
TLensesJsonObjectAccess >> object [

	^ self explicitRequirement
]

{ #category : #'api - json' }
TLensesJsonObjectAccess >> removeKey: aKey [

	self object removeKey: aKey
]
