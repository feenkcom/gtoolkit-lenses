Class {
	#name : #BaselineOfGToolkitLensesBasic,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitLensesBasic
}

{ #category : #baseline }
BaselineOfGToolkitLensesBasic >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'NeoJSON' with: [
				spec repository: 'github://svenvc/NeoJSON:v17/repository' ].

		spec package: 'GToolkit-Lenses-Model'.
		spec package: 'GToolkit-Lenses-Json' with: [
			spec requires: #('GToolkit-Lenses-Model' 'NeoJSON') ].
		spec package: 'GToolkit-Lenses-Examples' with: [
			spec requires: #('GToolkit-Lenses-Model' 'GToolkit-Lenses-Json') ].
	]
]
