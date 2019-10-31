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
		'telloDrone'
	],
	#category : #'Tello-Drone-Playground'
}

{ #category : #specs }
TDDroneCreationForm class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | 
			row
				add: #labelHost;
				add: #fieldHost ]
			height: self toolbarHeight;
		newRow: [ :row | 
			row
				add: #labelPort;
				add: #fieldPort ]
			height: self toolbarHeight;
		newRow: [ :row | row add: #buttonCreate ]
			height: self toolbarHeight;
		newRow: [ :row | 
			row
				add: #buttonConnect;
				add: #buttonDisconnect ]
			height: self toolbarHeight;
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
	^ 400 @ (self class toolbarHeight * 5.4)
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
			buttonConnect enable ].
	buttonConnect
		action: [ telloDrone connect.buttonDisconnect enable.
			buttonCreate disable.
			buttonConnect disable.
			 ].
	buttonDisconnect
		action: [ telloDrone disconnect .buttonCreate enable.
			buttonConnect enable.
			buttonDisconnect disable ]
]

{ #category : #initialization }
TDDroneCreationForm >> initializeWidgets [
	"widget instantiation"

	labelHost := self newLabel.
	fieldHost := self newTextInput autoAccept: true.
	labelPort := self newLabel.
	fieldPort := self newTextInput autoAccept: true.
	buttonCreate := self newButton.
	buttonConnect := self newButton.
	buttonDisconnect := self newButton.

	"widget configuration"
	labelHost label: 'Insert Tello Drone Host:'.
	fieldHost ghostText: '192.168.10.1'.
	labelPort label: 'Insert Tello Drone Port:'.
	fieldPort ghostText: '8889'.
	buttonCreate label: 'Create'.
	buttonConnect
		label: 'Connect';
		disable.
	buttonDisconnect
		label: 'Disconnect';
		disable.

	"specification of order of focus"
	self focusOrder
		add: fieldHost;
		add: fieldPort;
add:		buttonCreate  ;
		add: buttonConnect ;
		add:buttonDisconnect 
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
TDDroneCreationForm >> telloDrone [
	^ telloDrone
]

{ #category : #accessing }
TDDroneCreationForm >> telloDrone: anObject [
	telloDrone := anObject
]

{ #category : #api }
TDDroneCreationForm >> title [
	^ 'Tello Drone Creation Form'
]

{ #category : #'api-events' }
TDDroneCreationForm >> whenConnectDo: aBlock [
	buttonConnect  whenActionPerformedDo: aBlock
]

{ #category : #'api-events' }
TDDroneCreationForm >> whenCreateDo: aBlock [
buttonCreate whenActionPerformedDo: aBlock
]

{ #category : #'api-events' }
TDDroneCreationForm >> whenDisconnectDo: aBlock [
	buttonDisconnect whenActionPerformedDo: aBlock
]
