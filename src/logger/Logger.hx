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
	
}