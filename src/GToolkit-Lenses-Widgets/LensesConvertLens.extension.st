Extension { #name : #LensesConvertLens }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesConvertLens >> gtHistoryStepItemDisplayText [

	| aText aName |
	self name ifNil: [ ^ self gtDisplayString ].

	aText := 'Convert ' asRopedText.
	aName := LensesWidgetUtility styleKey: self name.

	aText append: aName.

	^ aText
]

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesConvertLens >> gtMappingsFor: aView [

	<gtView>
	self toMapping ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Mappings';
		  priority: 1;
		  object: [ self toMapping ];
		  view: #gtTreeFor:context:
]

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesConvertLens >> gtReversedMappingsFor: aView [

	<gtView>
	self toMapping ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Reversed Mappings';
		  priority: 2;
		  object: [ self reversedMapping ];
		  view: #gtTreeFor:context:
]
