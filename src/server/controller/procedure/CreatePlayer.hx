package server.controller.procedure;
import entity.Auth;
import entity.Character;
import entity.Dynasty;
import entity.Player;
import server.controller.Controller.AccessDenied;

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

	override public function process( o :CreatePlayerParam ) :Dynamic {
		
		// TODO : deny access on * but ...
		if ( !checkAccess() )
			return new AccessDenied('Require authentification with a fresh account');
		
		
		var oEntity = new Player( o.player_label );
		oEntity.setDynasty( new Dynasty( o.dynasty_label ) );
		oEntity.getDynasty().addCharacter( new Character( o.player_label, oEntity.getDynasty() ) );
		
		var oSessionData = _oController.getSession().getData();
		var oAuth :Auth = cast _oController.getDatabase().loadReference(oSessionData.auth); // TODO : cache from checkAccess
		oAuth.setPlayer( oEntity );
		var oDatabase = _oController.getDatabase();
		oDatabase.persist( oAuth );
		oDatabase.flush();
		
		return oEntity;
	}
	
	public function checkAccess() {
		var oSessionData = _oController.getSession().getData();
		if ( oSessionData == null )
			return false;
		
		//TODO : check session.auth != null
		var oAuth :Auth = cast _oController.getDatabase().loadReference(oSessionData.auth);
		if ( oAuth.getPlayer() != null )
			return false;
		
		return true;
	}
	
}