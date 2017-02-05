as yet unclassified
fixMacLineEndings
	<script>
	
	| command |
	command := ':%s/', Character cr asString, '/\r/g'.
	Clipboard clipboardText: command allButFirst.
	UIManager default inform: 'Paste into command mode'