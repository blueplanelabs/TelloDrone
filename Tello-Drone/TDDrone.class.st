Class {
	#name : #TDDrone,
	#superclass : #Object,
	#instVars : [
		'clientUDP',
		'stateMonitor',
		'droneAddress',
		'dronePort',
		'clientProcess'
	],
	#category : #'Tello-Drone'
}

{ #category : #construction }
TDDrone class >> toHost: anAddress port: aPort [
	"Constructor with the IP Address and the UDP Port of the Tello drone"

	^ self new
		toHost: (SocketAddress fromDottedString:anAddress)  port: aPort asInteger;
		yourself
]

{ #category : #'private - access' }
TDDrone >> clientUDP [
	clientUDP ifNil: [ clientUDP := Socket newUDP ].
	^ clientUDP
]

{ #category : #api }
TDDrone >> connect [
self sendCommand: 'command'.
	clientProcess := [ [ true ]
		whileTrue: [ self sendCommand: 'battery'.
			14 seconds asDelay wait ] ] forkAt: 20 named: 'UDP client'
]

{ #category : #api }
TDDrone >> disconnect [
	clientProcess terminate
]

{ #category : #'gt-inspector-extension' }
TDDrone >> gtInspectorItemsIn: composite [
	^ composite fastTable
		title: 'Items';
		display: [ self stateMonitor currentState associations ];
			column: 'Key'
			evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Value'
			evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ]
]

{ #category : #initialization }
TDDrone >> initialize [
	"initialize instanceVariables"

	super initialize.
	droneAddress := #[ 192 168 10 1 ] asSocketAddress.
	dronePort := 8889.
]

{ #category : #api }
TDDrone >> isMonitoring [
	^ self stateMonitor isActive
]

{ #category : #api }
TDDrone >> sendCommand: aCommand [
	"Trazas"
	Transcript crShow: aCommand.
	^ self clientUDP
		sendData: aCommand
		toHost: droneAddress
		port: dronePort
]

{ #category : #api }
TDDrone >> startMonitoring [ 
self stateMonitor start
]

{ #category : #'private - access' }
TDDrone >> stateMonitor [
	"return a TDStateMonitor instance"

	^ stateMonitor ifNil: [ stateMonitor := TDStateMonitor new ]
]

{ #category : #api }
TDDrone >> stopMonitoring [
	self stateMonitor stop
]

{ #category : #api }
TDDrone >> subscribe: anAnnunciableClass send: aSelector to: anObject [
	self stateMonitor
		subscribe: anAnnunciableClass
		send: aSelector
		to: anObject
]

{ #category : #initialization }
TDDrone >> toHost: anAddress port: aPort [

	"Constructor with the IP Address and the UDP Port of the Tello drone"
	
	droneAddress := anAddress.
	dronePort := aPort .
]

{ #category : #subscription }
TDDrone >> unsubscribe: anObject [
	self stateMonitor unsubscribe: anObject
]
