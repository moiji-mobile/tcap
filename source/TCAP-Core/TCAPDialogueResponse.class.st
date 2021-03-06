Class {
	#name : #TCAPDialogueResponse,
	#superclass : #TCAPDialogueAPDU,
	#instVars : [
		'diagnostic'
	],
	#category : #'TCAP-Core-Message'
}

{ #category : #accessing }
TCAPDialogueResponse class >> asn1TypeName [
	^ 'AARE-apdu'
]

{ #category : #'instance creation' }
TCAPDialogueResponse class >> dispatchInstanceCreationOn: aFactory [ 
	^ aFactory newDialogueResponse
]

{ #category : #'as yet unclassified' }
TCAPDialogueResponse class >> isAsn1ModelClass [
	^ true
]

{ #category : #'instance creation' }
TCAPDialogueResponse class >> serviceProvider [
	^ self new
		serviceProvider
]

{ #category : #accessing }
TCAPDialogueResponse >> accepted [
	self value at: 'result' put: 0
]

{ #category : #accessing }
TCAPDialogueResponse >> applicationContextNameNotSupported [
	self serviceUser contents: 2
]

{ #category : #converting }
TCAPDialogueResponse >> asContinueMessageIn: aFactory [
	^ aFactory newContinueMessage 
]

{ #category : #converting }
TCAPDialogueResponse >> asEndMessageIn: aFactory [
	^ aFactory newEndMessage 
		privAt: 'dialoguePortion' put: (aFactory dialoguePortionFromApdu: self);
		yourself 
]

{ #category : #accessing }
TCAPDialogueResponse >> diagnostic [
	^ self expandFieldNamed: 'result-source-diagnostic'
]

{ #category : #testing }
TCAPDialogueResponse >> isRefused [
	"application context name not supported or rejected"
	^ ((self diagnostic includesKey: 'dialogue-service-user') and: [ (self diagnostic at: 'dialogue-service-user') = 2 ])
		or: [ (self includesKey: 'result') and: [ (self at: 'result') = 1 ] ]

]

{ #category : #accessing }
TCAPDialogueResponse >> noCommonDialoguePortion [
	self serviceProvider value: 2
]

{ #category : #accessing }
TCAPDialogueResponse >> noReasonGiven [
	self source contents: 1
]

{ #category : #accessing }
TCAPDialogueResponse >> null [
	self source contents: 0
]

{ #category : #accessing }
TCAPDialogueResponse >> pduType [
	^ 'dialogueResponse'
]

{ #category : #accessing }
TCAPDialogueResponse >> rejectPermanent [
	self at: 'result' put: 1
		
]

{ #category : #accessing }
TCAPDialogueResponse >> serviceProvider [
	^ self diagnostic expandFieldNamed: 'dialogue-service-provider'
]

{ #category : #accessing }
TCAPDialogueResponse >> serviceUser [
	^ self diagnostic expandFieldNamed: 'dialogue-service-user'
]

{ #category : #'as yet unclassified' }
TCAPDialogueResponse >> source [
	^ self diagnostic soleValue
]
