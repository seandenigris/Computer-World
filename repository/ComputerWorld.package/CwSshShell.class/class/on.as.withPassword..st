instance creation
on: ipAddressString as: userString withPassword: passwordString

	^ self new
			ipAddress: ipAddressString;
			username: userString;
			password: passwordString;
			yourself.