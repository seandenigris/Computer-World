as yet unclassified
signatureList

	| signatureListFile doc |
	signatureListFile := self signatureFolder / 'AllSignatures.plist'.
	doc := XMLDOMParser parse: signatureListFile contents.
	^ doc allElementsNamed: #dict.