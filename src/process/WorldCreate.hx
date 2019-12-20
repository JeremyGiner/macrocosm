package process;
import entity.World;

/**
 * ...
 * @author GINER Jeremy
 */
class WorldCreate {

	public function new() {
	}
	
	public function process() {
		
		var oFactory = new WorldFactory();
		var oWorld = oFactory.create();
		
	}
	
}