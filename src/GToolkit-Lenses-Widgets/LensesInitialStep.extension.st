Extension { #name : #LensesInitialStep }

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesInitialStep >> gtHistoryFor: aView [

	^ aView columnedList
		  title: 'Changes';
		  priority: 5;
		  items: [ { self } ];
		  column: 'Name' text: #yourself
]

{ #category : #'*GToolkit-Lenses-Widgets' }
LensesInitialStep >> gtOutputFor: aView [

	^ aView empty
]
