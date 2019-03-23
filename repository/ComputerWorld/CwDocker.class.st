Class {
	#name : #CwDocker,
	#superclass : #Object,
	#category : #'ComputerWorld-Apps'
}

{ #category : #installation }
CwDocker class >> install [
	<script>
	Smalltalk tools webBrowser open: 'https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04'
]
