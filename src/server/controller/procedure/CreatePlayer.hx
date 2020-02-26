package server.controller.procedure;
import entity.Character;
import entity.Dynasty;
import entity.Player;
import server.view.EntityViewBuilder;


typedef CreatePlayerParam = {
	var player_label :String;
	var dynasty_label :String;
	var character_label :String;
}
/**
 * ...
 * @author ...
 */
class CreatePlayer extends AControllerProcedure<CreatePlayerParam> {

	override public function process( o :CreatePlayerParam ) {
		
		// TODO : deny access on * but ...
		
		var oEntity = new Player( o.player_label );
		oEntity.setDynasty( new Dynasty( o.dynasty_label ) );
		oEntity.getDynasty().addCharacter( new Character( o.player_label, oEntity.getDynasty() ) );
		
		
		var oDatabase = _oController.getDatabase();
		oDatabase.persist( oEntity );
		oDatabase.flush();
		
		var oBuilder = new EntityViewBuilder();
		return oBuilder.build( oEntity );
	}
	
}