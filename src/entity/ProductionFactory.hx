package entity;

/**
 * ...
 * @author GINER Jeremy
 */
interface IProductionBuilder {
	
	public function create( oProductor :Productor ) :Production;
	
}

class AProductionBuilder implements IProductionBuilder {
	
	public function new() {
		
	}
	
	public function create() {
		return new Production( oProductor, 
	}
	
}
 
 
class ProductionBuilderSimple {

	var _oProductionType :ProductType;
	
	public function new( oProductionType :ProductType ) {
		_oProductionType = oProductionType;
	}
	
	public function getType() {
		return _oProductionType;
	}
	
	
	
}

class ProductionBuilderChoice {
	
	var _aChoice :Array<ProductionType>;
	
	public function new( aChoice :Array<ProductionType> ) {
		_aChoice = aChoice;
	}
	
	public function getChoice() {
		return _aChoice;
	}
}