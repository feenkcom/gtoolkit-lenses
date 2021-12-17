Extension { #name : #Lenses }

{ #category : #'*GToolkit-Lenses-Json' }
Lenses class >> fromJsonString: aString [

	^ LensesJsonReader fromString: aString
]

{ #category : #'*GToolkit-Lenses-Json' }
Lenses >> gtJsonStringFor: aView [

	<gtView>
	self lenses ifNil: [ ^ aView empty ].

	^ aView textEditor
		  title: 'JSON';
		  tooltip: 'JSON Lenses model';
		  priority: 10;
		  styler: [ JSONParser gtStyler ];
		  text: [ self asJsonString ]
]

{ #category : #'*GToolkit-Lenses-Json' }
Lenses class >> jsonMappingV1Asociations [

	^ { 
		  ('schemaName' -> nil).
		  ('lenses' -> { TLenses }) }
]
