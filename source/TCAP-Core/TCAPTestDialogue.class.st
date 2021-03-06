Class {
	#name : #TCAPTestDialogue,
	#superclass : #TCAPDialogue,
	#category : #'TCAP-Core-Tests-Model'
}

{ #category : #accessing }
TCAPTestDialogue >> addLocalInvocationWithId: aNumber [ 
	 | invocation |
	invocation := (self asn1TypeNamed: 'Invoke') newValue
		invokeId: aNumber;
		dialogue: self.
	localInvocations add: invocation.
	^ invocation
]

{ #category : #'requests - for testing' }
TCAPTestDialogue >> requestTcAbortDestinationAddress: aDestinationAddress originatingAddress: anOriginatingAddress applicationContextName: anApplicationContextName [
	self state 
		requestTcAbortDestinationAddress: aDestinationAddress 
		originatingAddress: anOriginatingAddress 
		applicationContextName: anApplicationContextName
		userInformation: nil
]

{ #category : #'requests - for testing' }
TCAPTestDialogue >> requestTcAbortDestinationAddress: aDestinationAddress originatingAddress: anOriginatingAddress applicationContextName: anApplicationContextName userInformation: userInfo [
	self state 
		requestTcAbortDestinationAddress: aDestinationAddress 
		originatingAddress: anOriginatingAddress 
		applicationContextName: anApplicationContextName
		userInformation: userInfo
]

{ #category : #'requests - for testing' }
TCAPTestDialogue >> requestTcContinueDestinationAddress: aDestinationAddress originatingAddress: anOriginatingAddress applicationContextName: anApplicationContextName [
	self state 
		requestTcContinueDestinationAddress: aDestinationAddress 
		originatingAddress: anOriginatingAddress 
		applicationContextName: anApplicationContextName
		userInformation: nil
]

{ #category : #'requests - for testing' }
TCAPTestDialogue >> requestTcContinueDestinationAddress: aDestinationAddress originatingAddress: anOriginatingAddress applicationContextName: anApplicationContextName userInformation: aUserInformation [
	self state 
		requestTcContinueDestinationAddress: aDestinationAddress 
		originatingAddress: anOriginatingAddress 
		applicationContextName: anApplicationContextName
		userInformation: aUserInformation
]

{ #category : #'requests - for testing' }
TCAPTestDialogue >> requestTcEndDestinationAddress: aDestinationAddress originatingAddress: anOriginatingAddress applicationContextName: anApplicationContextName [
	self state 
		requestTcEndDestinationAddress: aDestinationAddress 
		originatingAddress: anOriginatingAddress 
		applicationContextName: anApplicationContextName
		userInformation: nil
]

{ #category : #'requests - for testing' }
TCAPTestDialogue >> requestTcEndDestinationAddress: aDestinationAddress originatingAddress: anOriginatingAddress applicationContextName: anApplicationContextName userInformation: aUserInformation [
	self state 
		requestTcEndDestinationAddress: aDestinationAddress 
		originatingAddress: anOriginatingAddress 
		applicationContextName: anApplicationContextName
		userInformation: aUserInformation
]

{ #category : #'as yet unclassified' }
TCAPTestDialogue >> setIDPoolForLowerValue [
	invokeIdPool startValue: -128
]

{ #category : #'as yet unclassified' }
TCAPTestDialogue >> setIDPoolForUpperValue [
	invokeIdPool startValue: 127
]
