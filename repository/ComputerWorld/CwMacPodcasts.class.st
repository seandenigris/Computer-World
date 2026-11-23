Class {
	#name : 'CwMacPodcasts',
	#superclass : 'CwMacApplication',
	#category : 'ComputerWorld',
	#package : 'ComputerWorld'
}

{ #category : 'utility' }
CwMacPodcasts class >> transcriptCacheForEpisodeID: aString [

	^ SuGenericUnixCommand new
		template: 'find "$HOME/Library/Group Containers/243LU875E5.groups.com.apple.podcasts/Library/Cache/Assets/TTML" -type f -name "*{episodeID}*" -print';
		argumentAt: #episodeID put: aString;
		outputDecoder: [ :outString | outString trimmed ifNotEmpty: #asFileReference ifEmpty: [ nil ] ];
		output.
		
	"Implementation note: path was wrong if input not trimmed"
]
