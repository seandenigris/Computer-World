Extension { #name : #Integer }

{ #category : #'*ComputerWorld' }
Integer >> asCwIPAddress [
	"This is a bit of a sacrilege for multiple reasons, the most glaring of which is that we're not actually representing an IP address (which is a suped up integer anyway) here, but a CIDR routing prefix"

	| shift max |
	shift := 32 - self.
	max := #[255 255 255 255] asInteger.
	^ CwIPAddress fromInteger: ((max bitShift: shift negated) bitShift: shift).

	"Other algorithms, baased on a discussion on Pharo Users(http://forum.world.st/Bit-Manipulation-Challenge-tp5119845.html):
	(max bitClear: (2 raisedTo: shift) - 1) asByteArray.
	((2 raisedTo: shift) - 1) bitInvert32 asByteArray.
	((2 raisedTo: cidr) - 1 bitShift: shift) asByteArray.
	((max bitShift: shift) rem: max + 1) asByteArray.
	(max << shift) asByteArray last: 4"
]
