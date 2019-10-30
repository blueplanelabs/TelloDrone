Class {
	#name : #TDDroneMonitoring,
	#superclass : #ComposablePresenter,
	#instVars : [
		'buttonStartMonitor',
		'buttonStopMonitor',
		'drone',
		'allWidgets'
	],
	#category : #'Tello-Drone-Playground'
}

{ #category : #specs }
TDDroneMonitoring class >> defaultSpec [
	^ SpecRowLayout composed add: #buttonStartMonitor;add: #buttonStopMonitor;yourself 
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
			buttonStopMonitor enable.
			buttonStartMonitor disable ].
		buttonStopMonitor action: [ drone stopMonitoring .
			buttonStartMonitor enable.
			buttonStopMonitor disable ]
]

{ #category : #initialization }
TDDroneMonitoring >> initializeWidgets [
	"widgets instantiation"

	allWidgets := OrderedCollection new.
	buttonStartMonitor := self newButton.
	buttonStopMonitor := self newButton.

	"widgets configuration"
	buttonStartMonitor
		label: 'Start Monitor';
		disable.
	allWidgets add: buttonStartMonitor.
	buttonStopMonitor
		label: 'Stop Monitor';
		disable.
		allWidgets add: buttonStopMonitor.

	"specification of order of focus"
	self focusOrder
		add: buttonStartMonitor;
		add: buttonStopMonitor
]
