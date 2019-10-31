Class {
	#name : #TDStateMonitor,
	#superclass : #Object,
	#instVars : [
		'stateAnnouncer',
		'server',
		'currentStateMonitored',
		'active'
	],
	#category : #'Tello-Drone'
}

{ #category : #initialization }
TDStateMonitor >> initialize [
	super initialize.
	self server.
	self stateAnnouncer.
	active:=false
]

{ #category : #api }
TDStateMonitor >> isActive [
	^active
]

{ #category : #'private actions' }
TDStateMonitor >> manageEvents: aStateInfo [
	aStateInfo = currentStateMonitored
		ifTrue: [ ^ self ].
	self stateAnnouncer announce: (TDStateChange state: aStateInfo).
	currentStateMonitored := aStateInfo.
"	Transcript
		show: currentState;
		cr.
	Transcript flush"
]

{ #category : #accessing }
TDStateMonitor >> server [
	^ server ifNil: [ server := TDUDPServer new ]
]

{ #category : #api }
TDStateMonitor >> start [
active:=true.
	self server start: [ :info | self manageEvents: info ]
]

{ #category : #accessing }
TDStateMonitor >> stateAnnouncer [
	^ stateAnnouncer ifNil: [ stateAnnouncer := Announcer new ]
]

{ #category : #api }
TDStateMonitor >> stop [
active:=false.
	self server stop
]

{ #category : #api }
TDStateMonitor >> subscribe: anAnnunciableClass do: aValuable [
self stateAnnouncer subscribe: anAnnunciableClass  do: aValuable 
	
]

{ #category : #api }
TDStateMonitor >> subscribe: anAnnunciableClass send: aSelector to: anObject [
	self stateAnnouncer subscribe: anAnnunciableClass send: aSelector to: anObject
]

{ #category : #api }
TDStateMonitor >> unsubscribe: anObject [
	self stateAnnouncer
		unsubscribe: anObject
]
