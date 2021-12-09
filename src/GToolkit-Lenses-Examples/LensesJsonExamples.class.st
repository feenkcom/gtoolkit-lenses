Class {
	#name : #LensesJsonExamples,
	#superclass : #Object,
	#category : #'GToolkit-Lenses-Examples'
}

{ #category : #reading }
LensesJsonExamples >> readHoistPrimaryTagLenses [

	<gtExample>
	| aLenses aJsonString |
	aJsonString := self writeHoistPrimaryTagLenses.

	aLenses := LensesJsonReader fromString: aJsonString.

	^ aLenses
]

{ #category : #reading }
LensesJsonExamples >> readMergeStreetNameAndNumberLenses [

	<gtExample>
	| aLenses aJsonString |
	aJsonString := self writeMergeStreetNameAndNumberLenses.

	aLenses := LensesJsonReader fromString: aJsonString.

	^ aLenses
]

{ #category : #reading }
LensesJsonExamples >> readSplitStreetNameAndNumberLenses [

	<gtExample>
	| aLenses aJsonString |
	aJsonString := self writeSplitStreetNameAndNumberLenses.

	aLenses := LensesJsonReader fromString: aJsonString.

	^ aLenses
]

{ #category : #writing }
LensesJsonExamples >> writeHoistPrimaryTagLenses [

	<gtExample>
	| aLenses aJsonString |
	aLenses := LensesAddressShowcase new hoistPrimaryTagLenses.

	aJsonString := aLenses asJsonString.

	^ aJsonString
]

{ #category : #writing }
LensesJsonExamples >> writeMergeStreetNameAndNumberLenses [

	<gtExample>
	| aLenses aJsonString |
	aLenses := LensesAddressShowcase new mergeAddressLinesLenses.

	aJsonString := aLenses asJsonString.

	^ aJsonString
]

{ #category : #writing }
LensesJsonExamples >> writeSplitStreetNameAndNumberLenses [

	<gtExample>
	| aLenses aJsonString |
	aLenses := LensesAddressShowcase new splitStreetNameAndNumberLenses.

	aJsonString := aLenses asJsonString.

	^ aJsonString
]
