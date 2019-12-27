package server.rudy.session;
import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;
import haxe.Serializer;
import haxe.Unserializer;
import haxe.io.Bytes;

/**
 * ...
 * @author 
 */
/**
 * TODO : remove serializer dependency
 */
class SessionRepository implements ISessionRepository {
    
    var _sDirectoryPath :String;
    
    public function new( sDirectoryPath :String ) {
        _sDirectoryPath = sDirectoryPath;
    }
	
	public function exist( sId :Null<String> ) {
		return FileSystem.exists( Path.join([_sDirectoryPath, sId]) );
	}
    
	public function save( oSession :Session<Dynamic> ) {

        Serializer.USE_CACHE = true;
        var s = Serializer.run( oSession.getData() );
        File.saveContent(
            Path.join([_sDirectoryPath,oSession.getId()]),
            s
        );
    }
    
    public function load( sId :Null<String> ) {
        
        if( sId == null ) return null;
        
        // get file by id
        var oBytes :Bytes = null;
        try {
        	oBytes = File.getBytes(Path.join([_sDirectoryPath, sId]));
        } catch( e :Dynamic ) {
            return null;
        }
        // TODO : check expiration date
        
        // unserialize
        var o = new Session( sId );
        o.setData( Unserializer.run( oBytes.toString() ) );
		
		return o;
    }
    
    /**
// TODO
        try {
        	destroy
        } catch( e :Dynamic) {
            Singleton.getInst(Logger).logWarning('trying to delete file "'+Path.join(_sDirectoryPath,sId)+'" '+e);
        }
*/
    public function destroy( sId :Null<String> ) {
        if( sId == null || sId == '' )
            return;
        FileSystem.deleteFile(Path.join([_sDirectoryPath,sId]));
    }
}



