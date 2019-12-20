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