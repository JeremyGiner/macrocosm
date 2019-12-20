package entity;

/**
 * ...
 * @author GINER Jeremy
 */
class Pawn extends Entity {

	var _aLocation :Array<Location>;
	var _oOwner :Dynasty;
	var _fCreated :Float; // in millisec	
	
	public function new(
		sLabel :String,
		oOwner :Dynasty,
		aLocation :Array<Location>
	) {
		super( sLabel );
		_oOwner = oOwner;
		_aLocation = aLocation;
		_fCreated = Date.now().getTime();
	}
	
	public function getCreationTimestamp() {
		return _fCreated;
	}
	
	public function getCreationDate() {
		return Date.fromTime( _fCreated ); 
	}
	
}