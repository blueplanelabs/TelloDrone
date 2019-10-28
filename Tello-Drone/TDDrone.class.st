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
	 toHost: anAddress port: aPort;
	yourself
]

{ #category : #accessing }
TDDrone >> clientUDP [
	clientUDP ifNil: [ clientUDP := Socket newUDP ].
	^ clientUDP
]

{ #category : #accessing }
TDDrone >> connect [
	clientProcess := [ [ true ]
		whileTrue: [ self clientUDP
				sendData: 'command'
				toHost: droneAddress
				port: dronePort.
			12 seconds asDelay wait ] ] forkAt: 70 named: 'UDP client'
]

{ #category : #accessing }
TDDrone >> disconnect [
	clientProcess terminate
]

{ #category : #initialization }
TDDrone >> initialize [
	"initialize instanceVariables"

	super initialize.
	droneAddress := #[ 192 168 10 1 ] asSocketAddress.
	dronePort := 8889.
]

{ #category : #'private protocol' }
TDDrone >> sendCommand: aCommand [
	self clientUDP sendData: aCommand toHost: droneAddress port: dronePort
]

{ #category : #accessing }
TDDrone >> stateMonitor [
	"return a TDStateMonitor instance"

	^ stateMonitor ifNil: [ stateMonitor := TDStateMonitor new ]
]

{ #category : #initialization }
TDDrone >> toHost: anAddress port: aPort [

	"Constructor with the IP Address and the UDP Port of the Tello drone"
	
	droneAddress := anAddress.
	dronePort := aPort .
]
