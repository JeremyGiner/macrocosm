package server.database;
import haxe.io.Path;
import storo.StorageString;
import storo.core.Database in BaseDatabase;
import entity.Auth;

/**
 * ...
 * @author ...
 */
class Database extends BaseDatabase {

	
	public function new() {
		
		super( new DatabaseMappingInfoProvider() );
		
		this.setStorage('entity.Auth', new StorageString<Auth>(
			this,
			'entity.Auth',
			new Path('Auth.storage'),
			this.getDefaultEncoder(),
			this.getDefaultDecoder(),
			new AuthEntityKeyProvider()
		) );
	}
	
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

