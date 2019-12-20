package entity.part;
import entity.World;

/**
 * ...
 * @author GINER Jeremy
 */
class Turn {

	var _oWorld :World;
	var _iId :Int;
	var _fProcessedDate :Null<Float>; // Timestamp in ms
	
//_____________________________________________________________________________
// Constructor
	
	public function new( oWorld :World, iId :Int ) {
		_oWorld = oWorld;
		_iId = iId;
		_fProcessedDate = null;
	}
	
//_____________________________________________________________________________
// Accessor
	
	public function getId() {
		return _iId;
	}
	
	public function getMonth() {
		return _iId % 8 + 1;
	}
	
	public function getYear() {
		return Math.floor( _iId / 8 ) + 100; 
	}
	
	public function getWorld() {
		return _oWorld;
	}
	
	public function getProccessedDate() {
		return _fProcessedDate;
	}
	
//_____________________________________________________________________________
// Modifier
	
	public function setProcessedDate( fTimeStamp :Float ) {
		_fProcessedDate = fTimeStamp;
	}
	// Just here to conform to Storo typedef OwnerId
	public function setId( id :Null<Int>) {
		throw 'not implemented';
	}
	
}