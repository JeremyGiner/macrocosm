package server.controller.procedure;
import entity.Auth;
import server.controller.Controller.AccessDenied;
import server.controller.Controller.UserMessage;
import server.view.EntityViewBuilder;


typedef SigninParam = {
	var login :String;
	var password :String;
}

/**
 * ...
 * @author 
 */
class Signin extends AControllerProcedure<SigninParam> {
	
	override public function process( o :SigninParam ) : Dynamic {
		
		// Get auth by email (login)
		var oAuth :Auth = null;
		if ( o.login == null ) 
			return new UserMessage('Invalid field login');
		
		var oDatabase = getController().getDatabase();
		oAuth = oDatabase.get( 'entity.Auth', o.login, true );//TODO :load player
		trace(oDatabase.getStorage('entity.Auth').getDescriptor().getPrimaryIndex());
		trace(oAuth.getPasswordShadow());
		trace(Auth.encode(o.password));
		trace(o.password);
		trace(oAuth.getPasswordShadow() != Auth.encode(o.password));
		if( 
			oAuth == null
			|| oAuth.getPasswordShadow() != Auth.encode(o.password)
		)
			return new AccessDenied(o.login);
		
		if( oAuth.getPlayer() != null )
			oDatabase.loadPartial(oAuth,['_oPlayer']);
		
		// Store in session
		// TODO : merge this block with Signin
		var oData = _oController.getSession().getData();
		var iPlayerId = (oAuth.getPlayer() != null ? oAuth.getPlayer().getId() : null);
		if ( oData == null )
			oData = {
				auth_level: 1, 
				player_id: iPlayerId,
			};
		else {
			oData.auth_level = 1;
			oData.player_id = iPlayerId;
		}
		_oController.getSession().setData( oData );
		
		return oAuth;
	}
}

