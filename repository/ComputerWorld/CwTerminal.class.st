Class {
	#name : #CwTerminal,
	#superclass : #Object,
	#category : #'ComputerWorld-Mac'
}

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
	safeCommand := aCommand copyReplaceAll: '"' with: '\"'.
	tellScript := scriptTemplate format: { #script -> safeCommand } asDictionary.
	Applescript tell: 'Terminal' to: tellScript
]
