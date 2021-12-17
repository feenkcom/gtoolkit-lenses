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

{ #category : #'examples - in addresses' }
LensesAddressShowcase >> executeRenameUserAddressesLenses [

	<gtExample>
	| aLenses aResult |
	aLenses := self renameUserAddressesLenses.

	aResult := aLenses execute: self userWithAddressesJsonString.

	self
		assert: aResult input object
		equals:
		(LensesInitialJsonObject fromString:
			 self userWithAddressesJsonString) object.
	self
		assert: aResult output object
		equals: self renamedUserAddressesJsonObject.

	^ aResult
]

{ #category : #'examples - merge' }
LensesAddressShowcase >> executeReversedMergeAddressLinesLenses [

	<gtExample>
	| aLenses aResult anInput |
	aLenses := self reversedMergeAddressLinesLenses.
	anInput := self executeMergeAddressLinesLenses output object copy.

	aResult := aLenses execute: anInput.

	self
		assert: aResult output object
		equals: self reversedMergedResultJsonObject.

	^ aResult
]

{ #category : #'examples - split' }
LensesAddressShowcase >> executeReversedSplitStreetNameAndNumberLenses [

	<gtExample>
	| aLenses aResult anInput |
	aLenses := self reversedSplitStreetNameAndNumberLenses.
	anInput := self executeSplitStreetNameAndNumberLenses output object copy.

	aResult := aLenses execute: anInput.

	self
		assert: aResult output object
		equals: self reversedSplitStreetNameAndNumberResultJsonObject.

	^ aResult
]

{ #category : #'examples - hoist' }
LensesAddressShowcase >> executeReversedTagsFieldsJsonString [

	<gtExample>
	| aLenses aResult anInput |
	aLenses := self reversedHoistPrimaryTagLenses.
	anInput := self executeTagsFieldsJsonString output object.

	aResult := aLenses execute: anInput.

	self
		assert: aResult output object
		equals: self reversedHoistTagsResultJsonObject.

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
		           remove: 'tags' defaultValue: Dictionary new.

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
		remove: 'state' defaultValue: '';
		remove: 'phone_number' defaultValue: '';
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

{ #category : #'examples - in addresses' }
LensesAddressShowcase >> renameUserAddressesLenses [

	<gtExample>
	| aLenses |
	aLenses := Lenses new 
		rename: 'login' to: 'username';
		in: 'addresses' do: [ :in | 
			in
				merge: 'address_line_one' and: 'address_line_two' format: '{1}, {2}';
				rename: 'address_line_one' to: 'street_name';
				add: 'country' value: 'Germany';
				remove: 'phone_number' ].

	self assert: aLenses lenses size equals: 2.
	self assert: aLenses lenses second lenses size equals: 4.

	^ aLenses
]

{ #category : #'examples - in addresses' }
LensesAddressShowcase >> renamedUserAddressesJsonObject [

	<gtExample>
	^ OrderedDictionary new
		  add: 'name' -> 'Annett T Wannemaker';
		  add: 'username' -> 'wannemaker';
		  add: 'addresses' -> { 
					  (OrderedDictionary new
						   add: 'street_name' -> 'Townhall Strasse, 24A Obergeschoss';
						   add: 'postalCode' -> '234223';
						   add: 'city' -> 'Bremen';
						   add: 'country' -> 'Germany';
						   yourself).

					  (OrderedDictionary new
						   add: 'street_name' -> 'Lützowplatz 112, apartment 23';
						   add: 'postalCode' -> '54429';
						   add: 'city' -> 'Heddert';
						   add: 'country' -> 'Germany';
						   yourself) };
		  yourself
]

{ #category : #'examples - hoist' }
LensesAddressShowcase >> reversedHoistPrimaryTagLenses [

	<gtExample>
	^ self hoistPrimaryTagLenses reversed
]

{ #category : #'examples - hoist' }
LensesAddressShowcase >> reversedHoistTagsResultJsonObject [

	<gtExample>
	^ OrderedDictionary new
		  add: 'street_name' -> 'Lützowplatz 112';
		  add: 'apartment_number' -> 'apartment 23';
		  add: 'postal_code' -> '54429';
		  add: 'city' -> 'Heddert';
		  add: 'full_name' -> 'Annett T Wannemaker';
		  add: 'tags' -> (Dictionary new
					   add: 'primary' -> 'true';
					   add: 'active' -> 'true';
					   yourself);
		  yourself
]

{ #category : #'examples - merge' }
LensesAddressShowcase >> reversedMergeAddressLinesLenses [

	<gtExample>
	^ self mergeAddressLinesLenses reversed
]

{ #category : #'examples - merge' }
LensesAddressShowcase >> reversedMergedResultJsonObject [

	<gtExample>
	^ OrderedDictionary new
		  add: 'full_name' -> 'Annett T Wannemaker';
		  add: 'postal_code' -> '54429';
		  add: 'city' -> 'Heddert';
		  add: 'country' -> 'Germany';
		  add: 'address_line_one' -> 'Lützowplatz 112';
		  add: 'address_line_two' -> 'apartment 23';
		  add: 'phone_number' -> '';
		  add: 'state' -> '';
		  yourself
]

{ #category : #'examples - split' }
LensesAddressShowcase >> reversedSplitStreetNameAndNumberLenses [

	<gtExample>
	^ self splitStreetNameAndNumberLenses reversed
]

{ #category : #'examples - split' }
LensesAddressShowcase >> reversedSplitStreetNameAndNumberResultJsonObject [

	<gtExample>
	^ OrderedDictionary new
		  add: 'full_name' -> 'Annett T Wannemaker';
		  add: 'postal_code' -> '54429';
		  add: 'city' -> 'Heddert';
		  add: 'address_line' -> 'Lützowplatz 112/23';
		  yourself
]

{ #category : #'examples - split' }
LensesAddressShowcase >> splitStreetNameAndNumberLenses [

	<gtExample>
	| aLenses |
	aLenses := Lenses new
		split: 'address_line' destination: 'street_number' regex: '^(.*) +([0-9]+/[0-9a-z]+)$' mergeFormat: '{1} {2}';
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
		  add: 'street_number' -> '112/23';
		  add: 'street_name' -> 'Lützowplatz';
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

{ #category : #'examples - in addresses' }
LensesAddressShowcase >> userWithAddressesJsonString [
	<gtExample>
	
	^ '{
	"name" : "Annett T Wannemaker",
	"login" : "wannemaker",
	"addresses" : [
		{
			"address_line_one" : "Townhall Strasse",
			"address_line_two" : "24A Obergeschoss",
			"postalCode" : "234223",
			"city" : "Bremen",
			"phone_number": "+49-157-555-3805"
		},
		{
			"address_line_one" : "Lützowplatz 112",
			"address_line_two" : "apartment 23",
			"postalCode" : "54429",
			"city" : "Heddert",
			"phone_number": "+49-157-555-3805"
		}
	]
}'
]
