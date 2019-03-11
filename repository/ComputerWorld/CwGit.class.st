Class {
	#name : #CwGit,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
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
