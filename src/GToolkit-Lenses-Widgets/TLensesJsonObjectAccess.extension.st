Extension { #name : #TLensesJsonObjectAccess }

{ #category : #'*GToolkit-Lenses-Widgets' }
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

{ #category : #'*GToolkit-Lenses-Widgets' }
TLensesJsonObjectAccess >> gtLiveFor: aView [

	^ aView forward
		  title: 'JSON';
		  priority: 1;
		  object: [ self ];
		  view: #gtJsonFor:context:
]

{ #category : #'*GToolkit-Lenses-Widgets' }
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
