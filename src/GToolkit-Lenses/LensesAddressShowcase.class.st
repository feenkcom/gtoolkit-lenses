Class {
	#name : #LensesAddressShowcase,
	#superclass : #Object,
	#category : #'GToolkit-Lenses-Examples'
}

{ #category : #'examples - amazon germany' }
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

{ #category : #'examples - amazon germany' }
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

{ #category : #accessing }
LensesAddressShowcase >> executeAmazonGermanLenses [

	<gtExample>
	| aLenses |
	aLenses := self amazonGermanyLenses.

	^ aLenses execute: self amazonGermanyJsonString
]
