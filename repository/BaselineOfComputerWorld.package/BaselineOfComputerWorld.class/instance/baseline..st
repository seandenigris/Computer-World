baseline
baseline: spec
  <baseline>

	spec for: #'common' do: [
		spec
			baseline: 'BabyPhexample' with: [
				spec repository: 'github://seandenigris/Baby-Phexample:master/repository' ];
			baseline: 'OSShell' with: [
				spec repository: 'github://seandenigris/Pharo-Shell:master/repository' ];
			baseline: 'ExternalWebBrowser' with: [
				spec repository: 'github://seandenigris/Pharo-Web-Browser:master/repository' ];
			baseline: 'Tempfile' with: [
				spec repository: 'github://seandenigris/TempfileSt:master/repository' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements:master/repository' ];
			baseline: 'Superuser' with: [
				spec repository: 'github://seandenigris/Superuser:master/src' ].
		spec package: 'ComputerWorld' with: [ spec requires: #(BabyPhexample OSShell ExternalWebBrowser PharoEnhancements Superuser) ] ].
