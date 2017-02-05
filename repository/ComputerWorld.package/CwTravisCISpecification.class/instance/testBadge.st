as yet unclassified
testBadge
	| expected actual |
	expected := '[![Build Status](https://travis-ci.org/seandenigris/Pharo-Shell.png?branch=master)](https://travis-ci.org/seandenigris/Pharo-Shell)'.
	actual := CwTravisCI new badgeMarkupForProject: 'Pharo-Shell' byUser: 'seandenigris'.
	actual should equal: expected