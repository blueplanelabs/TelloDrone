Class {
	#name : #TDUDPServer,
	#superclass : #Object,
	#instVars : [
		'serverSocket',
		'serverPort'
	],
	#category : #'Tello-Drone'
}

{ #category : #construction }
TDUDPServer class >> atPort: aPort [
	^ Socket newUDP
		setPort: aPort;
		yourself
]

{ #category : #initialization }
TDUDPServer >> initialize [
	"Initialize the UDP server"

	super initialize.
	serverSocket := Socket newUDP setPort: self serverPort.
	self data.
	
]

{ #category : #initialization }
TDUDPServer >> serverPort [
	 ^serverPort ifNil: [ serverPort := 8890 ]
]

{ #category : #operations }
TDUDPServer >> start: aBlock [
	| result buffer input state |
	buffer := String new: 256.
	input := 0.
	[ [ true ]
		whileTrue: [ [ result := serverSocket receiveUDPDataInto: buffer.
			result first > 0 ] whileFalse: [  ].
			input := buffer copyFrom: 1 to: result first.
			state := Dictionary
				newFromPairs: (input findBetweenSubstrings: #(':' ';')).
				aBlock value:  state] ]
		forkAt: Processor userBackgroundPriority
		named: 'UDP server'
]

{ #category : #accessing }
TDUDPServer >> stop [
	serverSocket closeAndDestroy .
	Processor suspendFirstAt: Processor userBackgroundPriority
]
