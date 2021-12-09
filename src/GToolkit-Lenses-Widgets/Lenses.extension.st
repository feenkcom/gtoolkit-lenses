Extension { #name : #Lenses }

{ #category : #'*GToolkit-Lenses-Widgets' }
Lenses >> gtLensesFor: aView [

	<gtView>
	^ aView tree
		  title: 'Lenses';
		  items: [ self lenses ];
		  children: [ :aProperty | aProperty gtLensesChildren ];
		  itemText: #gtHistoryStepItemDisplayText;
		  expandAll
]
