Class {
	#name : #TDLabelledContainer,
	#superclass : #LabelledContainer,
	#category : #'Tello-Drone-Playground'
}

{ #category : #specs }
TDLabelledContainer class >> defaultSpec [
	^ SpecLayout composed 
]

{ #category : #protocol }
TDLabelledContainer >> disable [
	self label disable.
	"self subwidget disable"
]

{ #category : #protocol }
TDLabelledContainer >> enable [
	self label enable
	"self subwidget disable"
]

{ #category : #api }
TDLabelledContainer >> showTableFrom: aTDStateChange [
	| tableDataSource |
	tableDataSource := TDFormTableDataSource for: aTDStateChange state.
	self subwidget widget dataSource: tableDataSource.
]
