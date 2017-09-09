as yet unclassified
signatures

	^ self signatureList collect: [ :e | CwMacMailSignature fromXML: e ] as: OrderedCollection