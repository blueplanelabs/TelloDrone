Class {
	#name : #TDDroneCommand,
	#superclass : #ComposablePresenter,
	#instVars : [
		'buttonCommand',
		'drone'
	],
	#category : #'Tello-Drone-Playground'
}

{ #category : #specs }
TDDroneCommand class >> defaultSpec [
	^ SpecLayout composed add: #buttonCommand
]

{ #category : #accessing }
TDDroneCommand >> buttonCommand [
	^ buttonCommand
]

{ #category : #accessing }
TDDroneCommand >> buttonCommand: anObject [
	buttonCommand := anObject
]

{ #category : #api }
TDDroneCommand >> buttonIcon: anIcon [
	buttonCommand icon: anIcon
]

{ #category : #initialization }
TDDroneCommand >> buttonLabel: aString [

	buttonCommand label: aString.

]

{ #category : #api }
TDDroneCommand >> disable [
buttonCommand disable.
]

{ #category : #accessing }
TDDroneCommand >> drone [
	^ drone
]

{ #category : #accessing }
TDDroneCommand >> drone: anObject [
	drone := anObject
]

{ #category : #api }
TDDroneCommand >> enable [
	buttonCommand enable
]

{ #category : #initialization }
TDDroneCommand >> initializePresenter [
	buttonCommand action: [ drone sendCommand: buttonCommand label asString  ]
]

{ #category : #initialization }
TDDroneCommand >> initializeWidgets [
	"widget instantiation"

	buttonCommand := self newButton.
	"widget configuration"
	buttonCommand label: 'command'.
	"specification of order of focus"
	self focusOrder add: buttonCommand 
]
