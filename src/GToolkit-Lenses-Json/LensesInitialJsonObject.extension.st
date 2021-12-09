Extension { #name : #LensesInitialJsonObject }

{ #category : #'*GToolkit-Lenses-Json' }
LensesInitialJsonObject class >> forString: aString [

	^ self forObject: (aString readStreamDo: [ :aStream | 
			   (NeoJSONReader on: aStream)
				   mapClass: OrderedDictionary;
				   next ])
]

{ #category : #'*GToolkit-Lenses-Json' }
LensesInitialJsonObject class >> fromString: aString [

	^ self forString: aString
]
