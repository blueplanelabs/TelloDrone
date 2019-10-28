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
		ifTrue: [ ^ self ].
	self stateAnnouncer announce: (TDStateChange state: aStateInfo).
	currentState := aStateInfo.
"	Transcript
		show: currentState;
		cr.
	Transcript flush"
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
	^ stateAnnouncer ifNil: [ stateAnnouncer := Announcer new ]
]

{ #category : #initialization }
TDStateMonitor >> stop [
	self server stop
]

{ #category : #initialization }
TDStateMonitor >> subscribe: anAnnunciableClass do: aValuable [
self stateAnnouncer subscribe: anAnnunciableClass  do: aValuable 
	
]

{ #category : #initialization }
TDStateMonitor >> subscribe: anAnnunciableClass send: aSelector to: anObject [
	self stateAnnouncer subscribe: anAnnunciableClass send: aSelector to: anObject
]

{ #category : #initialization }
TDStateMonitor >> unsubscribe: anObject [
	self stateAnnouncer
		unsubscribe: anObject
]
