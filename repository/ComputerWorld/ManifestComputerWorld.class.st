"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestComputerWorld,
	#superclass : #PackageManifest,
	#category : #'ComputerWorld-Manifest'
}

{ #category : #'code-critics' }
ManifestComputerWorld class >> ruleGRUsesCurlyBraceArraysRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#CwTerminal #doScript: #false)) #'2019-07-16T18:04:59.797063-04:00') )
]

{ #category : #'code-critics' }
ManifestComputerWorld class >> ruleRBUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#CwTerminal #doScript: #false)) #'2019-07-16T18:04:56.017126-04:00') )
]
