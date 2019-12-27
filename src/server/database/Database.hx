package server.database;
import storo.core.Database in BaseDatabase;
import entity.Auth;

/**
 * ...
 * @author ...
 */
class Database extends BaseDatabase {

	override public function getStorageByObject( o :Dynamic ) {
		var oClass = Type.getClass( o );
		
		if ( oClass == null ) return super.getStorageByObject( o );
		
		var sClassName = Type.getClassName( oClass );
		switch( sClassName ) {
			case 'entity.Auth': return getStorage(sClassName);
		}
		
		return super.getStorageByObject( o );
	}
	
}

