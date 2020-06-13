package server.database;
import haxe.io.Path;
import storo.StorageDefault;
import storo.StorageString;
import storo.core.Database in BaseDatabase;
import entity.Auth;
import storo.indexer.ForeignIdIndexer;
import storo.tool.VPathAccessor;
import sweet.functor.comparator.IntAscComparator;

/**
 * ...
 * @author ...
 */
class Database extends BaseDatabase {

	
	public function new() {
		
		super( new DatabaseMappingInfoProvider() );
		
		setStorage(new StorageString<Auth>(
			this,
			'entity.Auth',
			new Path('Auth.storage'),
			this.getDefaultEncoder(),
			this.getDefaultDecoder(),
			new AuthEntityKeyProvider()
		) );
		
		var o = new StorageDefault(
			this,
			'entity.Productor',
			new Path('Productor.storage'),
			this.getDefaultEncoder(),
			this.getDefaultDecoder()
		);
		o.addIndexer('by_owner', new ForeignIdIndexer<Int,Int>(
			new VPathAccessor('_oOwner'),
			new IntAscComparator()
		) );
		setStorage(o);
	}
	
	override public function getStorageByObject( o :Dynamic ) {
		var oClass = Type.getClass( o );
		
		if ( oClass == null ) return super.getStorageByObject( o );
		
		var sClassName = Type.getClassName( oClass );
		switch( sClassName ) {
			case 'entity.Auth','entity.Productor': return getStorage(sClassName);
		}
		
		return super.getStorageByObject( o );
	}
	
}

