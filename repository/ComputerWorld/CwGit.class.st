Class {
	#name : #CwGit,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #examples }
CwGit class >> example1 [
	| root gitRepos skipList potentials glRepos relevantRepos clone |
	
	self error: 'for documentation only, not made to be directly runnable'.
	root := FileLocator home / 'Dynabook' / 'Repositories' / 'seandenigris'.
	gitRepos := root directories select: [ :e | (e / '.git') exists ].
	skipList := #('Quote-Me' 'gitlab-smalltalk-ci').
	potentials := gitRepos reject: [ :e | skipList includes: e basename ].
	"noCiRepos := gitRepos select: [ :e | (e filesMatching: '*.yml') isEmpty ]."
	glRepos := potentials select: [ :e | (e / '.git' / 'config') contents includesSubstring: 'url = git@gitlab.com:SeanDeNigris/' ].
	relevantRepos := glRepos reject: [ :e | (e / '.gitlab-ci.yml') contents includesSubstring: 'pharo70_build' ].
	relevantRepos
		do: [ :e | 
			(e / '.gitlab-ci.yml') ensureDelete.
			FileLocator home / 'Documents/Reference/Smalltalk/Repositories/seandenigris/gitlab-smalltalk-ci/.gitlab-ci.yml' copyTo: e / '.gitlab-ci.yml' ].

	"e := glRepos first."
	relevantRepos
		do: [ :e | 
			clone := CwGit new localCloneAt: e.
			clone stageAll.
			clone commit: '[CI]: Update YML - Pharo 6.1 and 7 Builds'.
			clone push ].	"allButFirst"
	CwGitClone maAddField: #location

	"nonSrcRepos := glRepos reject: [ :e | (e / 'src') exists ].
nonSrcRepos collect: #directories."
]

{ #category : #installation }
CwGit class >> install [
	"Use Homebrew because suggested install method is via Sourceforge and from unidentified developer"
	<script>

	| installCommand scriptSafeUnixCommand scriptTemplate script command |
	installCommand := 'brew install git'.
	scriptSafeUnixCommand := installCommand copyReplaceAll: '"' with: '\"'.
	scriptTemplate := 'tell application "Terminal"
	do script "{installCommand}"
	activate
end tell'.
	script := scriptTemplate format: { #installCommand -> scriptSafeUnixCommand } asDictionary.
	command := 'osascript -e ''', script, ''''.
	Smalltalk tools shell command: command.
]

{ #category : #accessing }
CwGit >> localCloneAt: reference [
	^ CwGitClone new location: reference; yourself
]

{ #category : #commands }
CwGit >> removeCommitFromGitHub [
	"From https://stackoverflow.com/questions/448919/how-can-i-remove-a-commit-on-github
	
	git rebase -i HEAD~2
  git push origin +master"
]

{ #category : #commands }
CwGit >> squashCommitsSince: aString [
	"aString examples
		- short SHA for specific commit
		- HEAD~2 for 'last two commits'"
	
	'git rebase -i ', aString
]

{ #category : #commands }
CwGit >> syncCurrentBranchWithMaster [
	"
	Motivation: WIP (e.g. issue) commits will remain on top of any changes merged in from master, enabling a clean merge back when the issue is ready
	From: https://coderwall.com/p/7aymfa/please-oh-please-use-git-pull-rebase"
	'git pull --rebase'
]

{ #category : #commands }
CwGit >> update: remoteName remoteLocationTo: location [
	"http://stackoverflow.com/questions/30443333/error-with-renamed-repo-in-github-remote-this-repository-moved-please-use-th"
	
	^ 'git remote set-url ', remoteName, ' ', location
]
