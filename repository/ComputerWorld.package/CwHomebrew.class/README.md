There are two main choices for app installation target, each with different tradeoffs.

1. /Applications - After trying both, I ultimately settled on this because it fits better with Mac culture (see below). This method requires brewing as an administrator
2. ~/Applications - This seems attractive because you can brew from a non-admin account. However, in practice it's a PITA because too much of Mac assumes /Applications e.g. "Open with…"

Whichever of the above you choose, you have to #makeUsrLocalWritable by either your normal user (for #2) or an administrator (for #1).