Class {
	#name : #TDDronePlayground,
	#superclass : #ComposablePresenter,
	#instVars : [
		'creation',
		'commands',
		'monitor',
		'screen'
	],
	#category : #'Tello-Drone-Playground'
}

{ #category : #specs }
TDDronePlayground class >> defaultSpec [
	^ SpecColumnLayout composed
		add: #creation;
		add: #commands;
		add: #monitor;
		add: #screen;
		yourself
]

{ #category : #accessing }
TDDronePlayground >> commands [
	^ commands
]

{ #category : #accessing }
TDDronePlayground >> commands: anObject [
	commands := anObject
]

{ #category : #accessing }
TDDronePlayground >> creation [
	^ creation
]

{ #category : #accessing }
TDDronePlayground >> creation: anObject [
	creation := anObject
]

{ #category : #initialization }
TDDronePlayground >> initializePresenter [
	creation
		whenCreateDo: [ screen label: 'Created'.
			commands drone: creation telloDrone.
			monitor drone: creation telloDrone ].
	creation
		whenConnectDo: [ screen label: 'Connected'.
			commands enable.
			monitor enable ].
	creation
		whenDisconnectDo: [ screen label: 'Disconnected'.
			"Hacer que compruebe si está monitorizando y pararlo?
			telloDrone stopMonitoring?"
			commands disable.
			monitor disable ]
]

{ #category : #initialization }
TDDronePlayground >> initializeWidgets [
	"widgets instantiation"

	creation := self instantiate: TDDroneCreationForm.
	commands := self instantiate: TDDroneCommandsGroup.
	monitor := self instantiate: TDDroneMonitoring.
	screen := self newLabel.

	"widgets configuration"
	screen label: 'waiting click'.

	"specification of order of focus"
	self focusOrder
		add: creation;
		add: commands;
		add: monitor;
		add: screen
]

{ #category : #accessing }
TDDronePlayground >> monitor [
	^ monitor
]

{ #category : #accessing }
TDDronePlayground >> monitor: anObject [
	monitor := anObject
]

{ #category : #accessing }
TDDronePlayground >> screen [
	^ screen
]

{ #category : #accessing }
TDDronePlayground >> screen: anObject [
	screen := anObject
]
