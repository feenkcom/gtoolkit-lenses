Class {
	#name : #LensesAddressShowcase,
	#superclass : #Object,
	#category : #'GToolkit-Lenses-Examples'
}

{ #category : #'examples - merge' }
LensesAddressShowcase >> amazonGermanyJsonString [

	<gtExample>
	
	^ '{
		"full_name" : "Annett T Wannemaker",
		"phone_number" : "+49-157-555-3805",
		"address_line_one" : "Lützowplatz 112",
		"address_line_two" : "apartment 23",
		"postal_code" : "54429",
		"city" : "Heddert",
		"state" : "Rheinland-Pfalz",
		"country" : "Germany"
	}'
]

{ #category : #'examples - merge' }
LensesAddressShowcase >> executeMergeAddressLinesLenses [

	<gtExample>
	| aLenses aResult |
	aLenses := self mergeAddressLinesLenses.

	aResult := aLenses execute: self amazonGermanyJsonString.

	self assert: aResult output object equals: self mergedResultJsonObject.

	^ aResult
]

{ #category : #'examples - split' }
LensesAddressShowcase >> executeSplitStreetNameAndNumberLenses [

	<gtExample>
	| aLenses aResult |
	aLenses := self splitStreetNameAndNumberLenses.

	aResult := aLenses execute: self mergedStreetNameAndNumberJsonString.

	self
		assert: aResult output object
		equals: self splitStreetNameAndNumberResultJsonObject.

	^ aResult
]

{ #category : #'examples - hoist' }
LensesAddressShowcase >> executeTagsFieldsJsonString [

	<gtExample>
	| aLenses aResult |
	aLenses := self hoistPrimaryTagLenses.

	aResult := aLenses execute: self tagsFieldsJsonString.

	self
		assert: aResult output object
		equals: self hoistTagsResultJsonObject.

	^ aResult
]

{ #category : #'examples - hoist' }
LensesAddressShowcase >> hoistPrimaryTagLenses [

	<gtExample>
	| aLenses |
	aLenses := Lenses new
		rename: 'full_name' to: 'person_name';
		hoist: 'primary' from: 'tags';
		hoist: 'active' from: 'tags';
		rename: 'primary' to: 'is_primary';
		rename: 'active' to: 'is_active';
		remove: 'tags'.
		
	self assert: aLenses lenses size equals: 6.

	^ aLenses
]

{ #category : #'examples - hoist' }
LensesAddressShowcase >> hoistTagsResultJsonObject [

	<gtExample>
	^ OrderedDictionary new
		  add: 'street_name' -> 'Lützowplatz 112';
		  add: 'apartment_number' -> 'apartment 23';
		  add: 'postal_code' -> '54429';
		  add: 'city' -> 'Heddert';
		  add: 'person_name' -> 'Annett T Wannemaker';
		  add: 'is_primary' -> 'true';
		  add: 'is_active' -> 'true';
		  yourself
]

{ #category : #'examples - merge' }
LensesAddressShowcase >> mergeAddressLinesLenses [

	<gtExample>
	| aLenses |
	aLenses := Lenses new
		remove: 'state';
		remove: 'phone_number';
		merge: 'address_line_one' and: 'address_line_two' format: '{1}, {2}';
		rename: 'address_line_one' to: 'street_name'.

	^ aLenses
]

{ #category : #'examples - merge' }
LensesAddressShowcase >> mergedResultJsonObject [

	<gtExample>
	^ OrderedDictionary new
		  add: 'full_name' -> 'Annett T Wannemaker';
		  add: 'postal_code' -> '54429';
		  add: 'city' -> 'Heddert';
		  add: 'country' -> 'Germany';
		  add: 'street_name' -> 'Lützowplatz 112, apartment 23';
		  yourself
]

{ #category : #'examples - split' }
LensesAddressShowcase >> mergedStreetNameAndNumberJsonString [

	<gtExample>
	
	^ '{
		"full_name" : "Annett T Wannemaker",
		"address_line" : "Lützowplatz 112/23",
		"postal_code" : "54429",
		"city" : "Heddert"
		}'
]

{ #category : #'examples - split' }
LensesAddressShowcase >> splitStreetNameAndNumberLenses [

	<gtExample>
	| aLenses |
	aLenses := Lenses new
		split: 'address_line' destinations: #( 'street_number' ) regex: '^(.*)/([0-9a-z]+)$';
		rename: 'address_line' to: 'street_name';
		add: 'country' value: 'Germany'.  

	^ aLenses
]

{ #category : #'examples - split' }
LensesAddressShowcase >> splitStreetNameAndNumberResultJsonObject [

	<gtExample>
	^ OrderedDictionary new
		  add: 'full_name' -> 'Annett T Wannemaker';
		  add: 'postal_code' -> '54429';
		  add: 'city' -> 'Heddert';
		  add: 'street_number' -> '23';
		  add: 'street_name' -> 'Lützowplatz 112';
		  add: 'country' -> 'Germany';
		  yourself
]

{ #category : #'examples - hoist' }
LensesAddressShowcase >> tagsFieldsJsonString [

	<gtExample>
	 
	^ '{
		"full_name" : "Annett T Wannemaker",
		"street_name" : "Lützowplatz 112",
		"apartment_number" : "apartment 23",
		"postal_code" : "54429",
		"city" : "Heddert",
		"tags" : { 
			"primary" : "true",
			"active" : "true"
		}
	}'
]
