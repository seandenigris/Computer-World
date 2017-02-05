as yet unclassified
badgeMarkupForProject: project byUser: user

	| template |
	template := '[![Build Status](https://travis-ci.org/{user}/{project}.png?branch=master)](https://travis-ci.org/{user}/{project})'.
	^ template format: { 
			#project -> project.
			#user -> user } asDictionary