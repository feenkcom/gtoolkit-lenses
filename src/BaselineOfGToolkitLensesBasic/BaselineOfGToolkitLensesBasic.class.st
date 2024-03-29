Class {
	#name : #BaselineOfGToolkitLensesBasic,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitLensesBasic
}

{ #category : #baseline }
BaselineOfGToolkitLensesBasic >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'NeoJSON'
			with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ].

		spec package: 'GToolkit-Lenses-Model' with: [ spec requires: #(  ) ].

		spec
			package: 'GToolkit-Lenses-Json'
			with: [ spec requires: #( 'GToolkit-Lenses-Model'
			   'NeoJSON' ) ].

		spec
			package: 'GToolkit-Lenses-Examples'
			with: [ 
			spec requires: #( 'GToolkit-Lenses-Model' 'GToolkit-Lenses-Json' ) ] ]
]
