"
Original project abandoned and then forked to https://github.com/macvim-dev/homebrew-macvim

Configuration Files:
~/.viminfo
	.vim (folder)
	.vimrc
~/Documents/Reference/Windows XP Shared/vim_config/seans_settings.vim
"
Class {
	#name : #CwMacVim,
	#superclass : #CwSoftware,
	#category : #'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwMacVim class >> fixMacLineEndings [
	<script>
	
	| command |
	"From http://stackoverflow.com/questions/811193/how-to-convert-the-m-linebreak-to-normal-linebreak-in-a-file-opened-in-vim"
	command := ':%s/', Character cr asString, '/\r/g'.
	Clipboard clipboardText: command allButFirst.
	UIManager default inform: 'Paste into command mode'
]

{ #category : #'as yet unclassified' }
CwMacVim class >> install [
	"From https://github.com/macvim-dev/homebrew-macvim README"
	'brew tap macvim-dev/macvim' asSuCommand asRoot.
	'brew install --HEAD macvim-dev/macvim/macvim' asSuCommand asRoot.
]
