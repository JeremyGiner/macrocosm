package entity;

/**
 * ...
 * @author GINER Jeremy
 */
class ArrayStorableHolder<C> {

	var _iId :Null<Int>;
	var _a :Array<C>;
	
	public function new() {
		_a = new Array<C>();
	}
	
	//_____________________________________________________________________________
	
	public function getId() {
		return _iId;
	}
	
	public function setId( iId :Null<Int> ) {
		_iId = iId;
	}
	
	public function getArray() {
		return _a;
	}
	
	
}