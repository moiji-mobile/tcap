Class {
	#name : #TCAPServiceEndPoint,
	#superclass : #TCAPObject,
	#instVars : [
		'networkService',
		'transactionCoordinator',
		'dialogueHandler',
		'dialoguesAndTransactions',
		'idPool',
		'announcer'
	],
	#category : #'TCAP-Core-Model'
}

{ #category : #accessing }
TCAPServiceEndPoint class >> layer [
	^ self 
]

{ #category : #accessing }
TCAPServiceEndPoint class >> newForTesting [
	^ self new
		factory: TCAPTestObjectFactory new
]

{ #category : #accessing }
TCAPServiceEndPoint >> addDialogueAndTransaction: aDialogueAndTransaction [ 
	^ dialoguesAndTransactions add: aDialogueAndTransaction 
]

{ #category : #'as yet unclassified' }
TCAPServiceEndPoint >> addHandler: aHandler [
	aHandler registerAtServicePoint: announcer
]

{ #category : #accessing }
TCAPServiceEndPoint >> asn1Context: aContext [ 
	asn1Context := aContext
]

{ #category : #'as yet unclassified' }
TCAPServiceEndPoint >> basicNewDialogueAndTransaction [

	^ self factory newDialogueAndTransaction 
		container: self
]

{ #category : #accessing }
TCAPServiceEndPoint >> createNetworkService [
	^ SCCPMockNetworkService new.
]

{ #category : #accessing }
TCAPServiceEndPoint >> createTransactionCoordinator [
	^ self factory newTransactionCoordinator
		initializeWith: self networkService;
		container: self
		
]

{ #category : #accessing }
TCAPServiceEndPoint >> dialogueHandler [
	^ dialogueHandler ifNil: [ 
		dialogueHandler := self factory newDialogueHandler
			serviceEndPoint: self   ]
]

{ #category : #accessing }
TCAPServiceEndPoint >> dialoguesAndTransactions [
	^ dialoguesAndTransactions copy
]

{ #category : #finding }
TCAPServiceEndPoint >> findTransaction: aBlock [
	^ dialoguesAndTransactions 
		detect: [ :each | aBlock value: each transaction  ]
		ifNone: [ nil ]
]

{ #category : #testing }
TCAPServiceEndPoint >> hasTransactions [
	^ dialoguesAndTransactions notEmpty
]

{ #category : #accessing }
TCAPServiceEndPoint >> idPool [
	^ idPool ifNil: [ 
		idPool := self factory defaultIdPool ]
]

{ #category : #'initialize-release' }
TCAPServiceEndPoint >> initialize [
	super initialize.
	dialoguesAndTransactions := Set new.
	announcer := Announcer new
]

{ #category : #accessing }
TCAPServiceEndPoint >> installStateClass: aClass [
	self factory installStateClass: aClass
]

{ #category : #testing }
TCAPServiceEndPoint >> isIdle [
	self flag: #needsToDone.
	^ true
]

{ #category : #accessing }
TCAPServiceEndPoint >> networkService [
	^ networkService ifNil: [ 
		networkService := self createNetworkService.
		self transactionCoordinator initializeWith: networkService.
		networkService  ]
]

{ #category : #accessing }
TCAPServiceEndPoint >> networkService: aService [
	networkService := aService.
	self transactionCoordinator initializeWith: aService
]

{ #category : #'initialize-release' }
TCAPServiceEndPoint >> newDialogue [
	^ self newDialogueWithId: nil
]

{ #category : #accessing }
TCAPServiceEndPoint >> newDialogueAndTransaction [

	^ self newDialogueAndTransactionWithId: nil
]

{ #category : #accessing }
TCAPServiceEndPoint >> newDialogueAndTransactionWithId: aNumber [

	^ self basicNewDialogueAndTransaction
		allocateId: aNumber;
		register
]

{ #category : #'initialize-release' }
TCAPServiceEndPoint >> newDialogueWithId: aNumber [
	| dialogue |
	dialogue := (self newDialogueAndTransactionWithId: aNumber) dialogue.
	self notifyDialogueCreated: dialogue.
	^ dialogue
]

{ #category : #accessing }
TCAPServiceEndPoint >> newTransaction [
	^ self newDialogueAndTransaction transaction
]

{ #category : #'as yet unclassified' }
TCAPServiceEndPoint >> notifyDialogueCreated: aDialogue [
	announcer announce: (TCAPDialogueCreated dialogue: aDialogue)
]

{ #category : #'as yet unclassified' }
TCAPServiceEndPoint >> notifyDialogueReceived: aDialogue [
	announcer  announce: (TCAPDialogueReceived dialogue: aDialogue)
]

{ #category : #accessing }
TCAPServiceEndPoint >> onDialogue: aBlock [
	announcer
		on: TCAPDialogueReceived
		do: aBlock
]

{ #category : #removing }
TCAPServiceEndPoint >> removeDialogueAndTransaction: aDialogueAndTransaction [
	self idPool freeByteArray: aDialogueAndTransaction id.
	"dialogues and transactions can be released independently. As the object
	is shared a double remove is possible"
	dialoguesAndTransactions remove:aDialogueAndTransaction ifAbsent: [ ].
	announcer announce: (TCAPDialogueTerminated dialogue: aDialogueAndTransaction dialogue)
]

{ #category : #accessing }
TCAPServiceEndPoint >> transactionCoordinator [
	^ transactionCoordinator ifNil: [ 
		transactionCoordinator := self createTransactionCoordinator ]
]

{ #category : #accessing }
TCAPServiceEndPoint >> transactionCoordinator: aTCAPTransactionCoordinator [ 
	transactionCoordinator := aTCAPTransactionCoordinator.
	transactionCoordinator container: self
]