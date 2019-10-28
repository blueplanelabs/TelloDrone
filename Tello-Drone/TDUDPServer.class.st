Class {
	#name : #TDUDPServer,
	#superclass : #Object,
	#instVars : [
		'serverSocket',
		'serverPort',
		'serverProcess'
	],
	#category : #'Tello-Drone'
}

{ #category : #construction }
TDUDPServer class >> atPort: aPort [
|aTDUDPServer|
aTDUDPServer := self new.
aTDUDPServer serverPort: aPort.
^aTDUDPServer


]

{ #category : #initialization }
TDUDPServer >> initialize [
	"Initialize the UDP server"

	super initialize.
	self serverPort
]

{ #category : #initialization }
TDUDPServer >> serverPort [
	 ^serverPort ifNil: [ serverPort := 8890 ]
]

{ #category : #initialization }
TDUDPServer >> serverPort: aPort [
	serverPort := aPort
]

{ #category : #initialization }
TDUDPServer >> serverSocket [
	serverSocket
		ifNotNil: [ serverSocket isUnconnectedOrInvalid 
				ifFalse: [ ^ serverSocket ] ].
	^ serverSocket := Socket newUDP setPort: self serverPort
]

{ #category : #operations }
TDUDPServer >> start: aBlock [
	| result buffer input state |
	buffer := String new: 256.
	input := 0.
	serverProcess := [ [ true ]
		whileTrue: [ [ result := (self serverSocket) receiveUDPDataInto: buffer.
			result first > 0 ] whileFalse: [  ].
			input := buffer copyFrom: 1 to: result first.
			state := Dictionary
				newFromPairs: (input findBetweenSubstrings: #(':' ';')).
			aBlock value: state ] ]
		forkAt: Processor userBackgroundPriority
		named: 'UDP server'
]

{ #category : #accessing }
TDUDPServer >> stop [
	serverSocket closeAndDestroy .
	serverProcess terminate
	"	Processor scanSchedule: [ :proc | (proc name = 'UDP Server') ifTrue: [proc terminate ]] startingAt:  Processor userBackgroundPriority"
]
