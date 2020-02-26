package entity;

/**
 * ...
 * @author GINER Jeremy
 */
class Location {

	var _x :Int;
	var _y :Int;
	
	// ? sub-location : area / scene / room
	
	public function new( x :Int, y :Int ) {
		_x = x;
		_y = y;
	}
	
	static public function fromString( s :String ) :Location {
		try {
			var a = s.split(':');
			if ( a.length != 2 ) throw null;
			return new Location( 
				Std.parseInt( a[0] ), 
				Std.parseInt( a[1] ) 
			);
		} catch ( e :Dynamic ) {
			throw '"' + s + '" is not a valid Location';
		}
	}
	
	public function getY() {
		return _y;
	}
	public function getX() {
		return _x;
	}
	
	public function toString() {
		return _x + ':' + _y;
	}
	
	static public function STtoString( x :Int, y :Int ) {
		return x + ':' + y;
	}
	
	
}