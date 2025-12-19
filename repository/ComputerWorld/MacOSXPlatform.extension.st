Extension { #name : 'MacOSXPlatform' }

{ #category : '*ComputerWorld' }
MacOSXPlatform >> iPAddressForInterfaceNamed: aString [
	
	^ SuGenericUnixCommand new
		template: 'ipconfig getifaddr {deviceName}'; "via OSX Daily https://osxdaily.com/2010/08/08/lan-ip-address-mac/#comment-110377"
		argumentAt: #deviceName put: aString;
		outputDecoder: [ :str | 
			str 
				ifNotEmpty: [ CwIPAddress fromString: str ]
				ifEmpty: [ nil ] ];
		output
]

{ #category : '*ComputerWorld' }
MacOSXPlatform >> ipAddresses [
	"Default wifi adapter; `NetNameResolver localHostAddress` is buggy on Mac per its method comment"
	| ipString |
	self error: 'we may have several. `arp -a` gets all ips on the network and `ifconfig` gets all our Mac''s IPs, but output needs to be parsed'.
	ipString := Smalltalk tools shell new outputOf: 'ipconfig getifaddr en0'.
	^ CwIPAddress fromString: ipString 
]

{ #category : '*ComputerWorld' }
MacOSXPlatform >> networkAdapters [

	| output adapters |
	output := SuGenericUnixCommand new
		template: 'networksetup -listallhardwareports'; ""
		output.
		
	adapters := OrderedCollection new.
	
	(output lines allButLast: 3) readStreamDo: [ :str |
		| adapter |
		[ str atEnd ] whileFalse: [
			| deviceName ipAddress macAddress |
			str next. "Skip blank line"
			
			adapter := CwNetworkAdapter new
				description: (str next copyAfter: $:) allButFirst;
				yourself.
				
			deviceName := (str next copyAfter: $:) allButFirst.
			macAddress := CwMACAddress fromString: (str next copyAfter: $:) allButFirst.
			ipAddress := self iPAddressForInterfaceNamed: deviceName.
			
			adapter
				ipAddress: ipAddress;
				macAddress: macAddress.
			
			adapters add: adapter ] ].
			
	^ adapters
]
