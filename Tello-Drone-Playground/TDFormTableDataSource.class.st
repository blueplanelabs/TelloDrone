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
		addColumn:
			(FTColumn new
				id: 'Name';
				width: 50;
				yourself);
		addColumn:
			(FTColumn new
				id: 'Value';
				width: 50;
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
