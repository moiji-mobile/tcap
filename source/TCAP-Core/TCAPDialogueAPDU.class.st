Class {
	#name : #TCAPDialogueAPDU,
	#superclass : #ASN1AdaptiveTypeObject,
	#instVars : [
		'applicationContextName',
		'userInformation'
	],
	#category : #'TCAP-Core-Model'
}

{ #category : #converting }
TCAPDialogueAPDU >> asDialoguePdu [
self halt.
	^ (self asn1TypeNamed: 'DialoguePDU') newValue 
		at: self pduType put: self;
		yourself
]

{ #category : #converting }
TCAPDialogueAPDU >> asDialoguePduIn: aFactory [
	
	^ aFactory newDialoguePDU: self
]

{ #category : #converting }
TCAPDialogueAPDU >> asExternalValue [
	^ (self asDialoguePdu asExternalValue: (self asn1TypeNamed: 'dialogue-as-id'))
		type: (self asn1TypeNamed: 'DialoguePortion')
]

{ #category : #converting }
TCAPDialogueAPDU >> asExternalValueIn: aFactory [
	^ aFactory newDialoguePortion: (self asDialoguePduIn: aFactory)

]

{ #category : #accessing }
TCAPDialogueAPDU >> pduType [
	self subclassResponsibility 
]

{ #category : #accessing }
TCAPDialogueAPDU >> typeOid [
	^ typeOid
]

{ #category : #accessing }
TCAPDialogueAPDU >> typeOid: anOid [
	typeOid := anOid
]

{ #category : #accessing }
TCAPDialogueAPDU >> userInformation [
	^ userInformation
]

{ #category : #accessing }
TCAPDialogueAPDU >> userInformation: anObject [
	self at: 'user-information' put: anObject
]