package logger;
import sys.io.File;

/**
 * ...
 * @author 
 */
class Logger {
	
	static public var path = 'app.log';

	static public function log( s :String ) {
		File.append( path ).writeString( s );
	}
	
	static public function logError( s :String ) {
		trace('An error have been log to "'+path+'"');
		File.append( path ).writeString( '\nError: '+s );
	}
	
}