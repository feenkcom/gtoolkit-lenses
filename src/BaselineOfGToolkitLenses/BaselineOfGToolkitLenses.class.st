Class {
	#name : #BaselineOfGToolkitLenses,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitLenses
}

{ #category : #baseline }
BaselineOfGToolkitLenses >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'NeoJSON'
			with: [ spec repository: 'github://svenvc/NeoJSON:v17/repository' ].

		spec
			package: 'GToolkit-Lenses'
			with: [ spec requires: #( 'NeoJSON' ) ] ]
]
