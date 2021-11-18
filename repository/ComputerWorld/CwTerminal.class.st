Class {
	#name : #CwTerminal,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwTerminal class >> bundleBasename [
	^ 'Terminal.app'
]

{ #category : #preferences }
CwTerminal class >> changeFontSize [
	<script>
	Smalltalk tools webBrowser new open: 'https://apple.stackexchange.com/a/246281/9507' asUrl
	
	
]

{ #category : #API }
CwTerminal >> doScript: aCommand [

	| scriptTemplate tellScript safeCommand |
	scriptTemplate := '	activate
  do script "{script}"'.
	safeCommand := aCommand copyReplaceAll: '"' with: '\"'. "Literal quotes in an Applescript string must be escaped (see https://stackoverflow.com/a/10668503/424245)"
	tellScript := scriptTemplate format: { #script -> safeCommand } asDictionary.
	Applescript tell: 'Terminal' to: tellScript
]
