package server.controller;
import logger.Logger;
import haxe.CallStack;
import haxe.io.Path;
import haxe.ds.StringMap;
import server.controller.procedure.BuyProductor;
import server.controller.procedure.CreatePlayer;
import server.controller.procedure.InitWorld;
import server.controller.procedure.PersistObject;
import server.controller.procedure.RetrieveIndex;
import server.controller.procedure.RetrieveObject;
import server.controller.procedure.RetrieveSession;
import server.controller.procedure.Signin;
import server.controller.procedure.Signup;
import server.controller.procedure.Signout;
import server.database.AuthEntityKeyProvider;
import entity.mapper.ClientMappingInfoProvider;
import server.database.DatabaseMappingInfoProvider;
import server.rudy.session.Session;
import rudyhh.Response;
import server.rudy.session.SessionManager;
import server.database.Database;
import storo.StorageDefault;
import storo.StorageString;
import storo.StoroReference;
import storo.core.Storage;
import storo.query.Query;
import sweet.functor.comparator.ReflectComparator;
import sweet.functor.validator.Const;
import sweet.ribbon.MappingInfoProvider;
import server.controller.procedure.AControllerProcedure;
import sweet.ribbon.RibbonMacro;
import sys.FileSystem;
import sys.net.Host;
import entity.*;
import entity.worldmap.*;

typedef SessionData = {
	var auth_level :Int; // TODO : 
	var auth :StoroReference<Auth>;
}

/**
 * ...
 * @author GINER Jeremy
 */
class Controller {

	var _oDatabase :Database;
	var _oClientInfo :{host:Host, port:Int};
	var _oSessionManager :SessionManager<SessionData>;
	var _mProcedure :StringMap<AControllerProcedure<Dynamic>>;
	
	// Session key
	public static var USER_KEY = 'user';
	
//_____________________________________________________________________________
// Accessor

	public function new() {
		_oClientInfo = null;
		_oSessionManager = null;
		
		_oDatabase = new Database();
		
		// World generation
		if ( FileSystem.stat('Default.storage').size == 0 ) {
			
			//_oDatabase.getStorage('entity.Auth').addIndexer('login', new IndexerUniq( new Const(true), new ReflectComparator(!!!) ) )
			trace('WARNING : generating world');
			var o = new InitWorld( this );
			o.process(null);
			trace('WARNING : generating world DONE');
		}
		
		
		_mProcedure = new StringMap<AControllerProcedure<Dynamic>>();
		
		var a :Array<Dynamic> = [
			new Signin(this),
			new Signup(this),
			new Signout(this),
			
			new RetrieveObject(this),
			new PersistObject(this),
			new RetrieveIndex(this),
			new RetrieveSession(this),
			
			new BuyProductor(this),
			new CreatePlayer(this),
		];
		for( o in a )
			_mProcedure.set(o.getId(), o);
			
		
		// TODO : listen to database flush Auth, send confirm email
	}
	
//_____________________________________________________________________________
// Accessor
	
	public function getDatabase() {
		return _oDatabase;
	}
	
	public function getSession() {
		return _oSessionManager.getSession();
	}
	
//_____________________________________________________________________________
// Modifier

	public function setConnectionInfo( oClientInfo :{host:Host, port:Int} ) {
		_oClientInfo = oClientInfo;
	}
	
//_____________________________________________________________________________
// Process
	
	public function process( 
		oAction :IAction, 
		oSessionManager :SessionManager<SessionData> = null 
	) :Dynamic {
		
		_oSessionManager = oSessionManager;
		
		// Case : composite action
		if ( oAction.getProcedureName() == 'composite' ) {
			var aAction :Array<Dynamic> = cast oAction.getParam();
			var aResult :Array<Dynamic> = [];
			for ( oData in aAction ) {
				aResult.push( 
					process( new Action(
						oData.procedure, cast oData.param//TODO : use a factory
					) )
				);
			}
			return aResult;
		}
		
		// Case : singular action
		var oProcedure = _mProcedure.get( oAction.getProcedureName() );
		
		if( oProcedure == null )
			return new UserMessage(oAction.getProcedureName()+' not found');
		try {
			// TODO : validate param
			return oProcedure.process( cast oAction.getParam() );
		} catch( e :UserMessage ) {
			return e;
		} catch ( e :Dynamic ) {
			Logger.log('\nError: '+ e + CallStack.toString(CallStack.exceptionStack()) );
			return new Error('Server internal error : '+e);
		}
	}
	
//_____________________________________
// Database
	
	public function processRetrieveObjList( oQuery :Query ) {
		//oQuery
	}
	
//_____________________________________
	
	public function test() {
	
		// example Get user
		//process( new Action(Get,DB,{storage:'entity.Player',id:3}) );
	}
	
	//public function auth_action_access_check( oAction :IAction ) {
		//switch( oAction.getType() ) {
			//
			//case Login,Composite,Alias: return true;
			//case RetrieveObject:
				//
			//case PersistObject: 
				//
			//default: 
				//return false;
		//}
		//
		//return true;
	//}
}

class Message {
	
	var _sMessage :String;
	
	public function new( sMessage :String ) {
		_sMessage = sMessage;
	}
	public function getMessage() {
		return _sMessage;
	}
}

class UserMessage extends Message {

}

class Error extends Message {
	var _oCallstack :String;
	public function new( sMessage :String  ) {
		super(sMessage);
		_oCallstack = CallStack.toString(CallStack.callStack());
	}
	public function getCallstack() {
		return _oCallstack;
	}
}

class AccessDenied extends Message {
	
}