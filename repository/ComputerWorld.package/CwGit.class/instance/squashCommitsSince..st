commands
squashCommitsSince: aString
	"aString examples
		- short SHA for specific commit
		- HEAD~2 for 'last two commits'"
	
	'git rebase -i ', aString