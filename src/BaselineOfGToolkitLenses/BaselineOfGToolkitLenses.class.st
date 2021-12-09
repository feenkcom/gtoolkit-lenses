Class {
	#name : #BaselineOfGToolkitLenses,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitLenses
}

{ #category : #accessing }
BaselineOfGToolkitLenses class >> gtDependencyAnalysisPreloadedBaselines [

	^ super gtDependencyAnalysisPreloadedBaselines copyWith:
		  BaselineOfGToolkit
]

{ #category : #baseline }
BaselineOfGToolkitLenses >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'GToolkitLensesBasic'
			with: [ 
			spec repository: 'github://feenkcom/gtoolkit-lenses:main/src' ].

		spec
			package: 'GToolkit-Lenses-Widgets'
			with: [ spec requires: #( 'GToolkitLensesBasic' ) ] ]
]
