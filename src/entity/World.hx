package entity;
import entity.part.Turn;

/**
 * ...
 * @author GINER Jeremy
 */
class World extends Entity {
	
	var _oTurn :Turn; // Current turn
	var _oWorldMap :WorldMap;
	
	public function new() {
		super('MyWorld');
		
		_oTurn = new Turn( this, 0 );
	}
	
	public function loadMainContext() {
		
	}
	
	public function process() {
		
		// Process current turn
		
		// create next turn
		//_oTurn = 
	}
	
}