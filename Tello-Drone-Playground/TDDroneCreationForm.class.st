Class {
	#name : #TDDroneCreationForm,
	#superclass : #ComposablePresenter,
	#instVars : [
		'labelHost',
		'fieldHost',
		'labelPort',
		'fieldPort',
		'buttonCreate',
		'buttonConnect',
		'buttonDisconnect',
		'textScreen',
		'telloDrone'
	],
	#category : #'Tello-Drone-Playground'
}

{ #category : #specs }
TDDroneCreationForm class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row | 
			row
				add: #labelHost;
				add: #fieldHost ]
			origin: 0 @ 0
			corner: 1 @ 0.25;
		newRow: [ :row | 
			row
				add: #labelPort;
				add: #fieldPort ]
			origin: 0 @ 0.25
			corner: 1 @ 0.5;
		newRow: [ :row | row add: #buttonCreate ]
			origin: 0 @ 0.5
			corner: 1 @ 0.75;
		newRow: [ :row | 
			row
				add: #buttonConnect;
				add: #buttonDisconnect ]
			origin: 0 @ 75
			corner: 1 @ 1;
		yourself
]

{ #category : #accessing }
TDDroneCreationForm >> buttonConnect [
	^ buttonConnect
]

{ #category : #accessing }
TDDroneCreationForm >> buttonCreate [
	^ buttonCreate
]

{ #category : #accessing }
TDDroneCreationForm >> buttonDisconnect [
	^ buttonDisconnect
]

{ #category : #api }
TDDroneCreationForm >> extent [ 
^400@400
]

{ #category : #accessing }
TDDroneCreationForm >> fieldHost [
	^ fieldHost
]

{ #category : #accessing }
TDDroneCreationForm >> fieldPort [
	^ fieldPort
]

{ #category : #initialization }
TDDroneCreationForm >> initializePresenter [
	buttonCreate
		action: [ telloDrone := TDDrone toHost: fieldHost text port: fieldPort text.
			buttonConnect enable.
			buttonDisconnect enable .
			self show]
]

{ #category : #initialization }
TDDroneCreationForm >> initializeWidgets [
	"widget instantiation"

	textScreen := self newLabel.
	labelHost := self newLabel.
	fieldHost := self newTextInput autoAccept: true.
	labelPort := self newLabel.
	fieldPort := self newTextInput autoAccept: true.
	buttonCreate := self newButton.
	buttonConnect := self newButton.
	buttonDisconnect := self newButton.

	"widget configuration"
	textScreen label: 'Insert Host and Port of the Tello Drone'.
	labelHost label: 'Insert Tello Drone Host:'.
	fieldHost ghostText: '192.168.10.1'.
	labelPort label: 'Insert Tello Drone Port:'.
	fieldPort ghostText: '8889'.
	buttonCreate label: 'Create'.
	buttonConnect label: 'Connect'; disable.
	buttonDisconnect label: 'Disconnect'; disable.

	"specification of order of focus"
	self focusOrder
		add: fieldHost;
		add: fieldPort
]

{ #category : #accessing }
TDDroneCreationForm >> labelHost [
	^ labelHost
]

{ #category : #accessing }
TDDroneCreationForm >> labelPort [
	^ labelPort
]

{ #category : #accessing }
TDDroneCreationForm >> textScreen [
	^ textScreen
]

{ #category : #api }
TDDroneCreationForm >> title [ 
^'Tello Drone Creation'
]
