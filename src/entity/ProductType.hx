package entity;

/**
 * ...
 * @author GINER Jeremy
 */
class ProductType extends Entity {

	var _iBasePrice :Int;
	//var _aCategory :Array<????>;
	var _sDescription :String;
	
	public function new( sLabel, iBasePrice, sDescription ) {
		super( sLabel );
		
		_sDescription = sDescription;
		_iBasePrice = iBasePrice;
	}
	
}

class ProcductTypeCategory extends Entity {
	
}
