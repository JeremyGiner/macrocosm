package tool;
import haxe.io.Output;

/**
 * Usage : new Logger( File.append( 'file.log' ) )
 */
class Logger {
    
    var _sSeparator :String;
    var _oOuput :Output;
    
    public function new( 
        oOutput :Ouput, 
        sSeparator :String = "\n" 
    ) {
        _oOuput = oOutput;
    }
    
    public function logNotice( sMessage :String ) {
        _write( '[NOTICE] '+sMessage );
    }
    
    public function logWarning( sMessage :String ) {
        _write( '[WARNING] '+sMessage );
    }
    
    public function logError( sMessage :String ) {
        _write( '[ERROR] '+sMessage );
    }
    
    function _write( s :String ) {
        _oOuput.writeString( s+_sSeparator );
    }
}
