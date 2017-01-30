Example:

shell := SshShell on: ipAddress as: userName withPassword: password.
shell run: 'pwd'.
shell output.