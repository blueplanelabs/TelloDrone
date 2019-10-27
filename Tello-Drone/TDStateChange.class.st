Class {
	#name : #TDStateChange,
	#superclass : #Announcement,
	#instVars : [
		'state'
	],
	#category : #'Tello-Drone'
}

{ #category : #'accessing structure variables' }
TDStateChange class >> state: aStateInfo [
	"Create a new TDStateChange instance with the state of Tello drone"

^TDStateChange new state: aStateInfo ; yourself 
]

{ #category : #accessing }
TDStateChange >> state: aStateInfo [

	state := aStateInfo .
]
