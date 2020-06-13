package server.controller.procedure;
import entity.Auth;
import entity.Player;
import server.controller.Controller.AccessDenied;
import server.controller.Controller.UserMessage;
import storo.StoroReference;


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
		oAuth = oDatabase.get( 'entity.Auth', o.login, true );
		
		if( 
			oAuth == null
			|| oAuth.getPasswordShadow() != Auth.encode(o.password)
		)
			return new AccessDenied('Invalid login or password');
		
		// Store in session
		// TODO : merge this block with Signup
		var oData = _oController.getSession().getData();
		var oRef :StoroReference<Auth> = cast oDatabase.createRef( oAuth );

		if ( oData == null )
			oData = {
				auth_level: 1, 
				auth: oRef,
			};
		else {
			oData.auth_level = 1;
			oData.auth = oRef;
		}
		_oController.getSession().setData( oData );
		
		return oAuth;
	}
}

