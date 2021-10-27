Extension { #name : #MacOSXPlatform }

{ #category : #'*ComputerWorld' }
MacOSXPlatform >> ipAddresses [
	"Default wifi adapter; `NetNameResolver localHostAddress` is buggy on Mac per its method comment"
	| ipString |
	self error: 'we may have several. `arp -a` gets all ips on the network and `ifconfig` gets all our Mac''s IPs, but output needs to be parsed'.
	ipString := Smalltalk tools shell new outputOf: 'ipconfig getifaddr en0'.
	^ CwIPAddress fromString: ipString 
]
