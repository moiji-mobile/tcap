"
This is the intention revealing class name for TCAP operation sent class 3
"
Class {
	#name : #TCAPReportSuccess,
	#superclass : #TCAPOperationSentClass,
	#category : #'TCAP-Core-Message'
}

{ #category : #'as yet unclassified' }
TCAPReportSuccess class >> classNumber [
	^ 3
]

{ #category : #received }
TCAPReportSuccess class >> receivedReturnLast: aResultLast invocation: aInvocation [ 
	aInvocation 
		cancelTimer; "cancel invokation timer"
		switchToWaitForReject;		
		notifyReturnLast: aResultLast;
		switchToIdle.
		
		
]
