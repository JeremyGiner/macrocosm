package entity.worldmap;
import entity.Entity;
import haxe.ds.StringMap;

/**
 * ...
 * @author ...
 */
class Sector extends Entity {
	
	var _x :Int;
	var _y :Int;
	var _mTile :StringMap<Tile>;
	
	public function new( x :Int, y :Int, mTile :StringMap<Tile> ) {
		_x = x;
		_y = y;
		_mTile = new StringMap<Tile>();
		for ( o in mTile )
			_mTile.set(o.getX() + ';' + o.getY(), o);
		super('sector ' + _x + ';' + _y);
	}
	
	public function getX() {
		return _x;
	}
	
	public function getY() {
		return _y;
	}
	
	public function getTile( x :Int, y :Int ) {
		return _mTile.get( x+';'+y );
	}
	
	public function getTileMap() {
		return _mTile;
	}
}