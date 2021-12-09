Class {
	#name : #LensesWidgetUtility,
	#superclass : #Object,
	#category : #'GToolkit-Lenses-Widgets-Utilities'
}

{ #category : #'api - styling' }
LensesWidgetUtility class >> styleKey: aKey [

	| aText |
	aText := aKey asString asRopedText.
	aText highlight: Color lightGray; glamorousMonospaceBackground.
	
	^ aText
]
