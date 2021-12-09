Class {
	#name : #LensesRegexSplitter,
	#superclass : #Object,
	#instVars : [
		'string'
	],
	#category : #'GToolkit-Lenses-Model-Utilities'
}

{ #category : #'instance creation' }
LensesRegexSplitter class >> forString: aString [

	^ self new string: aString
]

{ #category : #accessing }
LensesRegexSplitter >> string [

	^ string
]

{ #category : #accessing }
LensesRegexSplitter >> string: anObject [

	string := anObject
]

{ #category : #splitting }
LensesRegexSplitter >> value: aString [

	| aRegex |
	aRegex := self string asRegex.
	(aRegex matches: aString) ifFalse: [ ^ #(  ) ].

	^ Array streamContents: [ :aStream | 
		  2 to: aRegex subexpressionCount do: [ :anIndex | 
			  | aResult |
			  aResult := aRegex subexpressions: anIndex.
			  aResult do: [ :anExpression | 
				  aStream nextPut: (anIndex - 1) -> anExpression ] ] ]
]
