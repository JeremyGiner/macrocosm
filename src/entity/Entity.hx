package entity;

/**
 * ...
 * @author GINER Jeremy
 */
@:keepSub
class Entity {

	var _iId :Null<Int>;
	var _sLabel :String;
	
	
//_____________________________________________________________________________
	
	public function new( sLabel :String ) {
		_iId = null;
		_sLabel = sLabel;
	}
	
//_____________________________________________________________________________
	
	public function getId() {
		return _iId;
	}
	
	public function setId( iId :Null<Int> ) {
		_iId = iId;
	}
	
	public function getLabel() {
		return _sLabel;
	}
	
	
}