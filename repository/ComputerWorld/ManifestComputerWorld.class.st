"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestComputerWorld,
	#superclass : #PackageManifest,
	#category : #'ComputerWorld-Manifest'
}

{ #category : #'code-critics' }
ManifestComputerWorld class >> ruleGRAnsiConvertorRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#CwSafari #videoSpeed: #false)) #'2020-08-15T16:32:14.828396-04:00') )
]

{ #category : #'code-critics' }
ManifestComputerWorld class >> ruleGRUsesCurlyBraceArraysRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#CwTerminal #doScript: #false)) #'2019-07-16T18:04:59.797063-04:00') )
]

{ #category : #'code-critics' }
ManifestComputerWorld class >> ruleRBUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#CwTerminal #doScript: #false)) #'2019-07-16T18:04:56.017126-04:00') #(#(#RGMethodDefinition #(#CwSafari #videoSpeed: #false)) #'2020-08-15T16:31:55.957266-04:00') )
]
