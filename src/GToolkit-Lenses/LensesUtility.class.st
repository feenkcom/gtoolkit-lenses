Class {
	#name : #LensesUtility,
	#superclass : #Object,
	#category : #'GToolkit-Lenses-Utilities'
}

{ #category : #'api - styling' }
LensesUtility class >> styleKey: aKey [

	| aText |
	aText := aKey asString asRopedText.
	aText highlight: Color lightGray; glamorousMonospaceBackground.
	
	^ aText
]
