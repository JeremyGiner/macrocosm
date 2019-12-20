package entity;
import sweet.functor.validator.IValidator;

/**
 * ...
 * @author GINER Jeremy
 */
class Productor extends Pawn {
	
	var _oType :ProductorType;
	var _iLevel :Int;
	//var _aWorker :Array<Character>;
	var _iCurrentPorduction :Int; //Index
	
	var _oTileRequirement :IValidator<Tile>;
	
	public function new( sLabel :String, oOwner :Dynasty, aLocation :Array<Location>  ) {
		super( sLabel, oOwner, aLocation );
	}
	// TODO
}