Class {
	#name : #TDStateMonitor,
	#superclass : #Object,
	#instVars : [
		'stateAnnouncer',
		'server'
	],
	#category : #'Tello-Drone'
}

{ #category : #initialization }
TDStateMonitor >> initialize [
super initialize.
	self server.
	self stateAnnouncer
]

{ #category : #accessing }
TDStateMonitor >> server [
	^ server ifNil: [ server := TDUDPServer new ]
]

{ #category : #accessing }
TDStateMonitor >> stateAnnouncer [
	^ stateAnnouncer ifNil: [ Announcer new ]
]
