Class {
	#name : #LensesRenameExamples,
	#superclass : #Object,
	#category : #'GToolkit-Lenses-Examples'
}

{ #category : #'examples - execution' }
LensesRenameExamples >> basicExecutor [
	<gtExample>
	
	| anExecutor |
	anExecutor := LensesExecutor new.
	
	self assert: anExecutor lenses isNil.
	self assert: anExecutor input isNil.
	self assert: anExecutor output isNil.
	
	^ anExecutor
]

{ #category : #'examples - properties' }
LensesRenameExamples >> basicProperty [

	<gtExample>
	| aProperty |
	aProperty := LensesRenameProperty new.

	self assert: aProperty source isNil.
	self assert: aProperty destination isNil.

	^ aProperty
]

{ #category : #accessing }
LensesRenameExamples >> execute [

	<gtExample>
	| anExecutor |
	anExecutor := self executor.

	anExecutor execute.

	self assert: anExecutor output isNotNil.
	self assert: anExecutor output object isNotNil.
	self assert: anExecutor output object keys equals: { 'description' }.

	^ anExecutor
]

{ #category : #'examples - execution' }
LensesRenameExamples >> executor [

	<gtExample>
	| anExecutor aProperty anInput |
	anExecutor := self basicExecutor.
	aProperty := self property.
	anInput := self input.
	
	anExecutor lenses: aProperty.
	anExecutor input: anInput.

	self assert: anExecutor lenses equals: aProperty.
	self assert: anExecutor input equals: anInput.

	^ anExecutor
]

{ #category : #'examples - support' }
LensesRenameExamples >> input [

	<gtExample>
	^ LensesInitialJsonObject forObject: (Dictionary new
			   at: 'body' put: 'I''m having a problem with this.';
			   yourself)
]

{ #category : #'examples - properties' }
LensesRenameExamples >> property [

	<gtExample>
	| aProperty |
	aProperty := self basicProperty.
	
	aProperty source: 'body'.
	aProperty destination: 'description'.
	
	self assert: aProperty source equals: 'body'.
	self assert: aProperty destination equals: 'description'.
	
	^ aProperty
]
