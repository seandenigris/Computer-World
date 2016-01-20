as yet unclassified
fieldsWith: fields
	"For example:"
	
	^ String streamContents: [ :str |
		fields keysAndValuesDo: [ :key :value | 
			str
				nextPutAll: '<</T(';
				nextPutAll: key;
				nextPutAll: ')/V(';
				nextPutAll: value;
				nextPutAll: ')>>';
				lf ] ].