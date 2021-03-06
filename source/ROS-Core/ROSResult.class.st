Class {
	#name : #ROSResult,
	#superclass : #ROSReply,
	#category : #'ROS-Core'
}

{ #category : #accessing }
ROSResult class >> asn1TypeName [
	^ 'ReturnResultNotLast'
]

{ #category : #accessing }
ROSResult class >> rosMessageType [
	^ 'returnResultNotLast'
]

{ #category : #decoding }
ROSResult >> decodeResult [
	self result result isAsn1EncodedValue
		ifFalse: [ ^ self ].
	self hasResultType
		ifFalse: [ 
			ROSInvocationError
				signal: 'decoding ' , self class name , ' failed because operation ' , self operationName , '  has no resultType ' ].
	self result privAt: 'result' put: (ASN1 read: self result result usingType: self resultType)
]

{ #category : #dispatching }
ROSResult >> dispatchTo: aDialogue [ 
	aDialogue receivedReturn: self
]

{ #category : #testing }
ROSResult >> hasResultType [
	^self resultType notNil
]

{ #category : #accessing }
ROSResult >> initializeFromDialogue: aDialogue [
	super initializeFromDialogue: aDialogue.
	invocation ifNil: [
		invocation  := (aDialogue asn1TypeNamed: 'Invoke') newValue.
		invocation invokeId: self invokeId.
		aDialogue setupReject: invocation.
		invocation dialogue: aDialogue.
		invocation returnReject: 2r00000000 type: 'returnResult'. 	
		^aDialogue requestTcContinue.
		].
	self hasResultType ifTrue: [
		(map includesKey: 'result') ifTrue: [ self decodeResult ]].
	
]

{ #category : #accessing }
ROSResult >> result: anObject [
	| res |

	anObject ifNotNil: [  
	self operation resultType ifNotNil: [  
		res := self expandFieldNamed: 'result'.
		(res expandFieldNamed: 'result') contents: anObject.
		(res expandFieldNamed: 'opcode') privAt: 'local' put: self operation operationCode ] ]
]

{ #category : #accessing }
ROSResult >> resultObject [
	^ (map at: 'result') at: 'result'
]

{ #category : #accessing }
ROSResult >> resultType [
	^ self operation resultType
]
