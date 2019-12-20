package entity.part;
import entity.TileCapacityType;


class TileCapacityRequirement { // TODO : validator
	
	var _aCapacityType :Array<TileCapacityType>;
	
	public function new( aCapacityType :Array<TileCapacityType> ) {
		_aCapacityType = aCapacityType;
	}
	
	public function getCapactityTypeAr() {
		return _aCapacityType;
	}
	
	public function getCost() {
		return 1;
	}
}