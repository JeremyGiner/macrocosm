package entity;
import haxe.ds.IntMap;
import tool.Macro;

/**
 * ...
 * @author GINER Jeremy
 */
class Tile {

	var _fElevation :Float;
	var _fHumidity :Float;
	var _fTemperature :Float;
	
	/**
	 * Indexed by TileCapacityType.id
	 */
	var _mProductCapacity :IntMap<Int>;
	
	//___________
	// Calculable
	
	var _iTerrainType :Int;
	var _oSouthTile :Tile;
	
//_____________________________________________________________________________
//	Constructor

	public function new( 
		fElevation :Float,
		fHumidity :Float,
		fTemperature :Float,
		mProductCapacity :IntMap<Int>
	) {
		Macro.ParamAssign();
	}
	
//_____________________________________________________________________________
//	Accessor

	public function getType() {
		return _iTerrainType;
	}
	
	public function getElevation() {
		return _fElevation;
	}
	
	public function getHumidity() {
		return _fHumidity;
	}
	
	public function getTemperature() {
		return _fTemperature;
	}
	
	public function getCapacityMap() {
		return _mProductCapacity;
	}
	
	/*
	public function getCity() {
		// query game 
	}
	*/
	
	/*
	public function getOvercrowd( _iProductTypeIndex ) {
		// query overcrowd
	}
	*/
	

	
}


