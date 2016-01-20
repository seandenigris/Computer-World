*ComputerWorld
isFinishedDownloading
	"This only works in my tidy little world where there are only-macs and we never leave .download files hanging around"

	^ (self containingDirectory includesKey: self name) not.