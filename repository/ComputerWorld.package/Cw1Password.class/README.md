cw := ComputerWorldDB data at: 1.
software := cw softwareNamed: '1Password'.
software downloadByOpening: 'http://agilebits.com/downloads/1Password/Mac' asUrl.
