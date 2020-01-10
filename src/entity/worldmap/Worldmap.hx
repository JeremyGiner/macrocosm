package entity.worldmap;
import haxe.ds.IntMap;
import haxe.ds.StringMap;
import tool.OpenSimplexNoise;
import tool.Tool;

/**
 * ...
 * @author GINER Jeremy
 */
class Worldmap extends Entity {

	// Index by Location.toString()
	//var _mTile :StringMap<Tile>;
	//var _oGenerator :WorldmapGenerator;
	var _mSector :StringMap<Sector>;
	
	static public var SECTOR_SIZE = 13;
	
	public function new() {
		_mSector = new StringMap<Sector>();
		super('Worldmap0');
		setId( -1 );
	}
	
	public function addSector( oSector :Sector ) {
		_mSector.set( _getSectorKey( oSector ), oSector );
	}
	
	public function getSector( x :Int, y :Int ) {
		return _mSector.get( _getSectorReverseKey(x, y) );
	}
	
	public function getSectorMap() {
		return _mSector;
	}
	
	function _getSectorKey( oSector :Sector ) {
		return oSector.getX() + ':' + oSector.getY();
	}
	function _getSectorReverseKey( x :Int, y :Int) {
		return x + ':' + y;
	}
}
