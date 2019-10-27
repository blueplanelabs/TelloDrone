Class {
	#name : #TDStateMonitor,
	#superclass : #Object,
	#instVars : [
		'stateAnnouncer',
		'server',
		'currentState'
	],
	#category : #'Tello-Drone'
}

{ #category : #initialization }
TDStateMonitor >> initialize [
	super initialize.
	self server.
	self stateAnnouncer
]

{ #category : #initialization }
TDStateMonitor >> manageEvents: aStateInfo [
	aStateInfo = currentState
		ifTrue: [^self].
		  self stateAnnouncer announce: (TDStateChange state: aStateInfo).
			currentState := aStateInfo 
]

{ #category : #accessing }
TDStateMonitor >> server [
	^ server ifNil: [ server := TDUDPServer new ]
]

{ #category : #initialization }
TDStateMonitor >> start [
	self server start: [ :info | self manageEvents: info ]
	
]

{ #category : #accessing }
TDStateMonitor >> stateAnnouncer [
	^ stateAnnouncer ifNil: [ Announcer new ]
]

{ #category : #initialization }
TDStateMonitor >> stop [
	self server stop
]
