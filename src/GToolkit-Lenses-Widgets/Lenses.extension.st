Extension { #name : #Lenses }

{ #category : #'*GToolkit-Lenses-Widgets' }
Lenses >> gtLensesFor: aView [

	<gtView>
	^ aView tree
		  title: 'Lenses';
		  priority: 1;
		  items: [ self lenses ];
		  children: [ :aProperty | aProperty gtLensesChildren ];
		  itemText: #gtHistoryStepItemDisplayText;
		  expandAll;
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'Reversed'
		  tooltip: 'Spawn reversed lenses'
		  action: [ :aButton | aButton phlow spawnObject: self reversed ]
]
