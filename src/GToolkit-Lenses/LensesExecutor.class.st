Class {
	#name : #LensesExecutor,
	#superclass : #Object,
	#instVars : [
		'lenses',
		'input'
	],
	#category : #'GToolkit-Lenses-Executors'
}

{ #category : #execution }
LensesExecutor >> execute [

	^ self input executor
		  lenses: self lenses;
		  execute;
		  step
]

{ #category : #accessing }
LensesExecutor >> input [

	^ input
]

{ #category : #accessing }
LensesExecutor >> input: anObject [

	input := anObject
]

{ #category : #accessing }
LensesExecutor >> lenses [

	^ lenses
]

{ #category : #accessing }
LensesExecutor >> lenses: anObject [

	lenses := anObject
]
