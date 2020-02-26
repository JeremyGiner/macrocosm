package entity;
import entity.worldmap.Tile;
import sweet.functor.validator.IValidator;

/**
 * ...
 * @author GINER Jeremy
 */
class Productor extends Pawn {
	
	var _oType :ProductorType;
	var _iLevel :Int;
	//var _aWorker :Array<Character>;
	var _iCurrentProduction :Int; //Index
	
	var _oTileRequirement :IValidator<Tile>;
	
//_____________________________________________________________________________
//	Constructor
	
	public function new( 
		sLabel :String, 
		oOwner :Dynasty, 
		aLocation :Array<Location>,
		oType :ProductorType
	) {
		super( sLabel, oOwner, aLocation );
		_oType = oType;
		_iLevel = 1;
		_iCurrentProduction = 0;
	}
	
//_____________________________________________________________________________
//	Accessor
	
	public function getCurrentProduction() {
		var a = _oType.getProductionType();
		if ( a.length <= _iCurrentProduction ) 
			return null;
		return a[_iCurrentProduction];
	}
	// TODO
}