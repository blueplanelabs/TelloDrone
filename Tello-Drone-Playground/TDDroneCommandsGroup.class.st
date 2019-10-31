Class {
	#name : #TDDroneCommandsGroup,
	#superclass : #ComposablePresenter,
	#instVars : [
		'takeoff',
		'land',
		'flip',
		'drone',
		'allWidgets'
	],
	#category : #'Tello-Drone-Playground'
}

{ #category : #specs }
TDDroneCommandsGroup class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | 
			row
				add: #takeoff;
				add: #land;
				add: #flip ]
			height: self toolbarHeight;
		yourself
]

{ #category : #api }
TDDroneCommandsGroup >> disable [
allWidgets do: [ :each | each disable ]
]

{ #category : #accessing }
TDDroneCommandsGroup >> drone [
	^ drone
]

{ #category : #accessing }
TDDroneCommandsGroup >> drone: anObject [
	drone := anObject.
allWidgets do: [ :each | each drone: anObject ]
	
]

{ #category : #api }
TDDroneCommandsGroup >> enable [
	allWidgets do: [ :each | each enable ]
]

{ #category : #accessing }
TDDroneCommandsGroup >> flip [
	^ flip
]

{ #category : #accessing }
TDDroneCommandsGroup >> flip: anObject [
	flip := anObject
]

{ #category : #initialization }
TDDroneCommandsGroup >> initializeWidgets [
	"widget instantiation"

	allWidgets := OrderedCollection new.
	takeoff := self instantiate: TDDroneCommand.
	allWidgets add: takeoff.
	land := self instantiate: TDDroneCommand.
	allWidgets add: land.
	flip := self instantiate: TDDroneCommand.
	allWidgets add: flip.

	"widget configuration"
	takeoff
		buttonLabel: 'takeoff';
		disable.
	land
		buttonLabel: 'land';
		disable.
	flip
		buttonLabel: 'flip f';
		disable.

	"specification of order of focus"
	self focusOrder
		add: takeoff;
		add: land;
		add: flip
]

{ #category : #accessing }
TDDroneCommandsGroup >> land [
	^ land
]

{ #category : #accessing }
TDDroneCommandsGroup >> land: anObject [
	land := anObject
]

{ #category : #accessing }
TDDroneCommandsGroup >> takeoff [
	^ takeoff
]

{ #category : #accessing }
TDDroneCommandsGroup >> takeoff: anObject [
	takeoff := anObject
]
