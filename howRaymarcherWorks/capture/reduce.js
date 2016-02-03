var exec = require( 'child_process' ).exec;

var zerofill = function( _num, _wid ) {
	var str = String( _num );
	if ( _wid <= str.length ) {
		return str;
	} else {
		return new Array( _wid - str.length + 1 ).join( '0' ) + str;
	}
};

for ( var iFrame = 0; iFrame < 401; iFrame ++ ) {
	var infile = zerofill( iFrame, 4 ) + '.png';
	var outfile = 'out' + zerofill( iFrame, 4 ) + '.png';
	exec( 'convert ' + infile + ' -resize 400x400 ' + outfile );
}
