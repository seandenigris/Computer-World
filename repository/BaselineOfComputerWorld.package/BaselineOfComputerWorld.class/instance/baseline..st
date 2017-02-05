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
				spec repository: 'github://seandenigris/Pharo-Web-Browsere:master/repository' ].
		spec package: 'ComputerWorld' with: [ spec requires: #(BabyPhexample OSShell ExternalWebBrowser) ] ].
