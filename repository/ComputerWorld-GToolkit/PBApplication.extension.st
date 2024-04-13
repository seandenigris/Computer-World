Extension { #name : #PBApplication }

{ #category : #'*ComputerWorld-GToolkit' }
PBApplication class >> cwInstallAllModules [

	| pipFile projectPipfiles |
	pipFile := CwPipfile new.
		
	projectPipfiles := (FileLocator localDirectory / 'iceberg') allFiles select: [ :e | e basename = 'Pipfile' ]. 
	projectPipfiles do: [ :ppf | pipFile mergeIn: ppf asRlResource ].
	
	pipFile packages keysDo: [ :pkgName | self uniqueInstance installModule: pkgName ].
]
