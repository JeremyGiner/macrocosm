package server.database;
import storo.core.IKeyProvider;
import entity.Auth;
import storo.core.NotStorableException;

/**
 * Key provider for the storage of Auth entity
 * @author ...
 */
class AuthEntityKeyProvider implements IKeyProvider<String,Auth> {

	public function new() {
	}
	
	public function get( o :Auth ) :String {
		if ( o.getEmail() == null )
			throw 'Auth with null value as email';
		return o.getEmail();
	}
	
}