Extension { #name : 'RlVideo' }

{ #category : '*ComputerWorld' }
RlVideo >> speechEnhance [

	^ CwAdobePodcast fromCatalog speechEnhance: self 
]
