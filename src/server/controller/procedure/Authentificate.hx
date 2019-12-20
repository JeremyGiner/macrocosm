package server.controller.procedure;
import server.controller.Controller;
import server.controller.Controller.Message;
import rudyhh.Response;
import server.controller.Auth;


typedef LogIn = {
	var login :String;
	var password :String;
}

/**
 * ...
 * @author 
 */
class Authentificate extends AControllerProcedure<LogIn> {
	
	override public function process( o :LogIn ) {
		
		// Get auth by email (login)
		var oAuth :Auth = null;
		if( o.login != null ) {
		
			var oDatabase = getController().getDatabase();
			var oAuth = oDatabase.get( 'Auth', o.login );//TODO :load player
			
			if( 
				oAuth == null
				|| oAuth.getPasswordShadow() != oAuth.encode(o.password)
			)
				return new AccessDenied(o.login);
		}
		
		// Store in session
		getController().getSession().set(Controller.USER_KEY,oAuth.getLogin());
		
		return null;
	}
}

class AccessDenied extends Message {
	
}