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
LensesAddressShowcase >> amazonGermanyLenses [

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
LensesAddressShowcase >> executeAmazonGermanLenses [

	<gtExample>
	| aLenses |
	aLenses := self amazonGermanyLenses.

	^ aLenses execute: self amazonGermanyJsonString
]

{ #category : #'examples - split' }
LensesAddressShowcase >> executeSplitStreetNameAndNumberLenses [

	<gtExample>
	| aLenses |
	aLenses := self splitStreetNameAndNumberLenses.

	^ aLenses execute: self mergedStreetNameAndNumberJsonString
]

{ #category : #'examples - hoist' }
LensesAddressShowcase >> executeTagsFieldsJsonString [

	<gtExample>
	| aLenses |
	aLenses := self hoistPrimaryTagLenses.

	^ aLenses execute: self tagsFieldsJsonString 
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

	^ aLenses
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
