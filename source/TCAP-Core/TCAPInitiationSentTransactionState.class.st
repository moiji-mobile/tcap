Class {
	#name : #TCAPInitiationSentTransactionState,
	#superclass : #TCAPTransactionState,
	#category : #'TCAP-Core-State'
}

{ #category : #accessing }
TCAPInitiationSentTransactionState class >> label [
	^ #initiationSent
]

{ #category : #requests }
TCAPInitiationSentTransactionState >> abortWithReason: aDictionary [
	"this is purely local action so just clear local state"
	transaction stop
]

{ #category : #'as yet unclassified' }
TCAPInitiationSentTransactionState >> receivedContinue: aMessage [ 
	self flag: #unchecked.
	transaction remoteTransactionId: aMessage otid.
	transaction switchState: #active.
	transaction dialogue indicationTrContinue: aMessage
]

{ #category : #indications }
TCAPInitiationSentTransactionState >> receivedEnd: aMessage [ 
	self flag: #unchecked.
	transaction dialogue indicationTrEnd: aMessage.
	transaction stop
]

{ #category : #indications }
TCAPInitiationSentTransactionState >> receivedPAbort: aMessage [ 
	self flag: #unchecked.
	transaction dialogue indicationTrPAbort: aMessage.
	transaction stop
]

{ #category : #indications }
TCAPInitiationSentTransactionState >> receivedUAbort: aMessage [ 
	self flag: #unchecked.
	transaction dialogue indicationTrUAbort: aMessage.
	transaction stop
]

{ #category : #requests }
TCAPInitiationSentTransactionState >> requestPreArrangedEndWithUserData: anObject [
	self flag: #unchecked.
	transaction stop
]