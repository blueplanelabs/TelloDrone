Class {
	#name : #TDDroneMonitoring,
	#superclass : #ComposablePresenter,
	#instVars : [
		'buttonStartMonitor',
		'buttonStopMonitor',
		'status',
		'drone',
		'allWidgets',
		'statusTable'
	],
	#category : #'Tello-Drone-Playground'
}

{ #category : #specs }
TDDroneMonitoring class >> defaultSpec [
	^ SpecRowLayout composed
		newColumn: [ :column | 
			column
				add: #buttonStartMonitor;
				add: #buttonStopMonitor;
				yourself ];
		newColumn: [ :column | column add: #status ];yourself 
]

{ #category : #accessing }
TDDroneMonitoring >> buttonStartMonitor [
	^ buttonStartMonitor
]

{ #category : #accessing }
TDDroneMonitoring >> buttonStartMonitor: anObject [
	buttonStartMonitor := anObject
]

{ #category : #accessing }
TDDroneMonitoring >> buttonStopMonitor [
	^ buttonStopMonitor
]

{ #category : #accessing }
TDDroneMonitoring >> buttonStopMonitor: anObject [
	buttonStopMonitor := anObject
]

{ #category : #api }
TDDroneMonitoring >> disable [
	allWidgets do: [ :each | each disable ]
]

{ #category : #accessing }
TDDroneMonitoring >> drone: anObject [
	drone := anObject.

]

{ #category : #api }
TDDroneMonitoring >> enable [
	buttonStartMonitor enable.
	buttonStopMonitor disable.
]

{ #category : #initialization }
TDDroneMonitoring >> initializePresenter [
	buttonStartMonitor
		action: [ drone startMonitoring.
			drone subscribe: TDStateChange send: #showTableFrom: to: status.
			buttonStopMonitor enable.
			buttonStartMonitor disable.
			status enable ].
	buttonStopMonitor
		action: [ drone stopMonitoring.
			buttonStartMonitor enable.
			buttonStopMonitor disable.
			status disable ]
]

{ #category : #initialization }
TDDroneMonitoring >> initializeWidgets [
	"widgets instantiation"

	allWidgets := OrderedCollection new.
	buttonStartMonitor := self newButton.
	buttonStopMonitor := self newButton.
	status := self instantiate: TDLabelledContainer.

	"widgets configuration"
	buttonStartMonitor
		label: 'Start Monitor';
		disable.
	allWidgets add: buttonStartMonitor.
	buttonStopMonitor
		label: 'Stop Monitor';
		disable.
	allWidgets add: buttonStopMonitor.
	status
		label: 'Tello Drone Status';
		subwidget: (statusTable := self newDataTable);
		disable.
	allWidgets add: status.
	self focusOrder
		add: buttonStartMonitor;
		add: buttonStopMonitor


	"specification of order of focus"
]

{ #category : #accessing }
TDDroneMonitoring >> newDataTable [
	| aTable |
	aTable := FTTableMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		asSpecAdapter.
	"	tableDataSource := TDFormTableDataSource for: self model."
	aTable widget beResizable.
	aTable widget
		addColumn:
			(FTColumn new
				id: 'Name';
				width: 110;
				yourself);
		addColumn:
			(FTColumn new
				id: 'Value';
				yourself).
	"	tableDataSource addColumnsTo: aTable widget.
	aTable widget dataSource: tableDataSource."
	^ aTable
]

{ #category : #accessing }
TDDroneMonitoring >> status [
	^ status
]

{ #category : #accessing }
TDDroneMonitoring >> status: anObject [
	status := anObject
]
