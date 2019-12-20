package server.controller;
import haxe.CallStack;
import logger.Logger;
import server.controller.procedure.Authentificate;
import server.controller.procedure.InitWorld;
import server.controller.procedure.PersistObject;
import server.controller.procedure.RetrieveIndex;
import server.controller.procedure.RetrieveObject;
import haxe.ds.StringMap;
import server.rudy.session.Session;
import rudyhh.Response;
import storo.core.Database;
import storo.query.Query;
import sweet.ribbon.MappingInfoProvider;
import server.controller.procedure.AControllerProcedure;
import sweet.ribbon.RibbonMacro;
import sweet.ribbon.MappingInfo;
import entity.part.TileCapacityRequirement;
import entity.part.TileCapacityOvercrowd;

import entity.*;


/**
 * ...
 * @author GINER Jeremy
 */
class Controller {

	var _oDatabase :Database;
	var _mProcedure :StringMap<AControllerProcedure<Dynamic>>;
	
	// Session key
	public static var USER_KEY = 'user';
	
//_____________________________________________________________________________
// Accessor

	public function new() {
		var oMappingProvider = new MappingInfoProvider();
		
		// TOOD : automatise
		RibbonMacro.setMappingInfo( oMappingProvider, TileCapacityRequirement );
		RibbonMacro.setMappingInfo( oMappingProvider, Tile );
		RibbonMacro.setMappingInfo( oMappingProvider, TileCapacityOvercrowd );
		RibbonMacro.setMappingInfo( oMappingProvider, TileCapacityType );
		RibbonMacro.setMappingInfo( oMappingProvider, ProductType );
		RibbonMacro.setMappingInfo( oMappingProvider, Production );
		RibbonMacro.setMappingInfo( oMappingProvider, ProductionType );
		RibbonMacro.setMappingInfo( oMappingProvider, Productor );
		RibbonMacro.setMappingInfo( oMappingProvider, ProductorType );
		
		_oDatabase = new Database( oMappingProvider );
		
		// World generation
		if ( false ) {
			trace('WARNING : generating world');
			var o = new InitWorld( this );
			o.process(null);
		}
		
		
		_mProcedure = new StringMap<AControllerProcedure<Dynamic>>();
		
		var a :Array<Dynamic> = [
			new Authentificate(this),
			new RetrieveObject(this),
			new PersistObject(this),
			new RetrieveIndex(this),
		];
		for( o in a )
			_mProcedure.set(o.getId(), o);
	}
	
//_____________________________________________________________________________
// Accessor
	
	public function getDatabase() {
		return _oDatabase;
	}
	
	public function getSession() {
		//return TODO;
		return null;
	}
	
//_____________________________________________________________________________
// Process
	
	public function process( 
		oAction :IAction, 
		oSession :Session<Dynamic> = null 
	) :Dynamic {
		
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
	
	public function auth_action_access_check( oAction :IAction ) {
		switch( oAction.getType() ) {
			
			case Login,Composite,Alias: return true;
			case RetrieveObject:
				
			case PersistObject: 
				
			default: 
				return false;
		}
		
		return true;
	}
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
	
}