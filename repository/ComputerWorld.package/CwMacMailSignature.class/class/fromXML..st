instance creation
fromXML: aXMLElement

	aXMLElement assert: (aXMLElement nodes at: 6) contentString = 'SignatureName'.
	aXMLElement assert: ((aXMLElement nodes at: 7) isKindOf: XMLString).
	aXMLElement assert: (aXMLElement nodes at: 10) contentString = 'SignatureUniqueId'.
	aXMLElement assert: ((aXMLElement nodes at: 11) isKindOf: XMLString).
	
	^ self new
			name: (aXMLElement nodes at: 8) contentString;
			id: (aXMLElement nodes at: 12) contentString;
			yourself