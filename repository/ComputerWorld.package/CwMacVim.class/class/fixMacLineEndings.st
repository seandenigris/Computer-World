as yet unclassified
fixMacLineEndings
	<script>
	
	| command |
	"From http://stackoverflow.com/questions/811193/how-to-convert-the-m-linebreak-to-normal-linebreak-in-a-file-opened-in-vim"
	command := ':%s/', Character cr asString, '/\r/g'.
	Clipboard clipboardText: command allButFirst.
	UIManager default inform: 'Paste into command mode'