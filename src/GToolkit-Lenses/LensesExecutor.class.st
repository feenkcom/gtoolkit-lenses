Class {
	#name : #LensesExecutor,
	#superclass : #Object,
	#instVars : [
		'lenses',
		'input',
		'output'
	],
	#category : #'GToolkit-Lenses-Executors'
}

{ #category : #execution }
LensesExecutor >> execute [

	| anOutput |
	anOutput := self input executor
		            lenses: self lenses;
		            execute;
		            output.

	self output: anOutput
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

{ #category : #accessing }
LensesExecutor >> output [

	^ output
]

{ #category : #accessing }
LensesExecutor >> output: anObject [

	output := anObject
]
