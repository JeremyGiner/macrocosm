package entity.worldmap;
import haxe.ds.IntMap;
import tool.Macro;

enum abstract CapacityType(Int) {
	var FIELD; // 33
	var FOREST; //34
	var STONE; // 37
	var IRON; // 44
	var GOLD; // 45
	var FISH; // 35
}

/**
 * ...
 * @author GINER Jeremy
 */
class Tile {

	var _x :Int;
	var _y :Int;
	
	var _fElevation :Float;
	var _fHumidity :Float;
	var _fTemperature :Float;
	
	/**
	 * Indexed by enum CapacityType
	 */
	var _mProductCapacity :IntMap<Int>;
	
	//___________
	// Calculable
	
	var _iTerrainType :Int;
	var _oSouthTile :Tile;
	
//_____________________________________________________________________________
//	Constructor

	public function new( 
		x :Int,
		y :Int,
		fElevation :Float,
		fHumidity :Float,
		fTemperature :Float,
		mProductCapacity :IntMap<Int>
	) {
		Macro.ParamAssign();
		trace('_________');
		trace(mProductCapacity);
		
	}
	
//_____________________________________________________________________________
//	Accessor

	public function getX() {
		return _x;
	}
	public function getY() {
		return _y;
	}

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

	public function getCapacity( i :CapacityType ) {
		return _mProductCapacity.get( cast i );
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


