as yet unclassified
linuxVmSwapCmdAndCtrl
	"Reference: https://askubuntu.com/questions/131900/how-do-i-switch-the-command-key-and-control-key-on-a-macbook-pro"
	
	"Put the following in ~/.Xmodmap:

clear control
clear mod4

keycode 133 = Control_L NoSymbol Control_L
keycode 134 = Control_R NoSymbol Control_R
keycode 37 = Super_L NoSymbol Super_L

add control = Control_L
add control = Control_R
add mod4 = Super_L

To test, run the command:

xmodmap ~/.Xmodmap

To make it run every time, add it to Startup Applications."