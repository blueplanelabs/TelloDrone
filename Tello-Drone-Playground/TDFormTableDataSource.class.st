Class {
	#name : #TDFormTableDataSource,
	#superclass : #FTSimpleDataSource,
	#instVars : [
		'model'
	],
	#category : #'Tello-Drone-Playground'
}

{ #category : #'instance creation' }
TDFormTableDataSource class >> for: aModel [
	^ self new
		model: aModel;
		elements: aModel associations;
		yourself 
]

{ #category : #adding }
TDFormTableDataSource >> addColumnsTo: aTable [

	aTable
		addColumn: (FTColumn new 
			id: 'Name';
			width: 110;
			yourself);
		addColumn: (FTColumn new 
			id: 'Value';
			yourself)		


]

{ #category : #accessing }
TDFormTableDataSource >> cellColumn: column row: rowIndex [ 
	
	| item |
	
	item := self elementAt: rowIndex.

	column id = 'Name' ifTrue: [ ^ item key asStringMorph ].
	column id = 'Value' ifTrue: [ ^ item value asStringMorph ].



]

{ #category : #accessing }
TDFormTableDataSource >> model [
	^ model
]

{ #category : #accessing }
TDFormTableDataSource >> model: anObject [
	model := anObject.

]

{ #category : #accessing }
TDFormTableDataSource >> refreshElements [

	self elements: { 
		'name' -> self model name.
		'surname' -> self model surname.
		'number 1' -> self model number1.
		'number 2' -> self model number2.
		'scale' -> self model scale.
		'password' -> self model password.
		'rememberMe' -> self model rememberMe.
		'date' -> self model date.
		'gender' -> self model gender.
		'items' -> self model selectedItems }
]
