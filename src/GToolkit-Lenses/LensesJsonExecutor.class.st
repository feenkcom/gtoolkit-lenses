Class {
	#name : #LensesJsonExecutor,
	#superclass : #Object,
	#instVars : [
		'lenses',
		'input',
		'output'
	],
	#category : #'GToolkit-Lenses-Executors'
}

{ #category : #execution }
LensesJsonExecutor >> execute [

	self lenses accept: self
]

{ #category : #accessing }
LensesJsonExecutor >> input [

	^ input
]

{ #category : #accessing }
LensesJsonExecutor >> input: anObject [

	input := anObject
]

{ #category : #accessing }
LensesJsonExecutor >> lenses [

	^ lenses
]

{ #category : #accessing }
LensesJsonExecutor >> lenses: anObject [

	lenses := anObject
]

{ #category : #accessing }
LensesJsonExecutor >> output [

	^ output
]

{ #category : #accessing }
LensesJsonExecutor >> output: anObject [

	output := anObject
]

{ #category : #visiting }
LensesJsonExecutor >> visitLenses: aProperty [

	aProperty lenses do: [ :eachProperty | eachProperty accept: self ]
]

{ #category : #visiting }
LensesJsonExecutor >> visitLensesRenameProperty: aProperty [

	| anObject |
	anObject := self output object copy.
	self output object: anObject.

	anObject
		at: aProperty source
		ifPresent: [ :aValue | 
			anObject 
				at: aProperty destination 
				put: aValue.
			anObject removeKey: aProperty source ]
		ifAbsent: [ 
			anObject 
				at: aProperty destination 
				put: aProperty defaultValue ]
]
