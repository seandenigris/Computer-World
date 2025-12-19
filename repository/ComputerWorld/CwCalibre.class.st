"
# Conversion
- Choose tablet input device to keep images at full scale ([via reddit](https://www.reddit.com/r/Calibre/comments/ji6nkn/best_settings_for_converting_azw3_to_epub/))
"
Class {
	#name : 'CwCalibre',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'accessing' }
CwCalibre class >> downloadUrl [
	^ 'https://github.com/kovidgoyal/calibre/releases/' asUrl
]

{ #category : 'accessing' }
CwCalibre class >> downloadUrlExample [
	"Homebrew uses insecure methods. See https://github.com/caskroom/homebrew-cask/blob/master/Casks/calibre.rb"
	^ 'https://github.com/kovidgoyal/calibre/releases/download/v2.45.0/calibre-2.45.0.dmg' asUrl
]
