package server.controller.procedure;
import server.controller.Auth;
import server.controller.Controller.AccessDenied;


typedef SigninParam = {
	var login :String;
	var password :String;
}

/**
 * ...
 * @author 
 */
class Signin extends AControllerProcedure<SigninParam> {
	
	override public function process( o :SigninParam ) {
		
		// Get auth by email (login)
		var oAuth :Auth = null;
		if( o.login != null ) {
		
			var oDatabase = getController().getDatabase();
			oAuth = oDatabase.get( 'Auth', o.login );//TODO :load player
			
			if( 
				oAuth == null
				|| oAuth.getPasswordShadow() != oAuth.encode(o.password)
			)
				return new AccessDenied(o.login);
		}
		
		// Store in session
		var oData = _oController.getSession().getData();
		oData.auth_level = 1;
		_oController.getSession().setData( oData );
		
		return null;
	}
}

