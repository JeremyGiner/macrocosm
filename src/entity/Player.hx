package entity;

/**
 * ...
 * @author GINER Jeremy
 */
class Player extends Entity {

	var _oDynasty :Dynasty;
	
	public function new( sLabel ) {
		super( sLabel );
		_oDynasty = null;
	}
	
	public function getDynasty() {
		return _oDynasty;
	}
	
	public function setDynasty( oDynasty :Dynasty ) {
		_oDynasty = oDynasty;
	}
	
}