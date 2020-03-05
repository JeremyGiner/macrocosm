package server.controller.procedure;
import haxe.Json;
import haxe.Serializer;
import entity.worldmap.Worldmap;
import entity.worldmap.Sector;
import haxe.ds.StringMap;

import haxe.CallStack;

/**
 * ...
 * @author 
 */

 typedef DbGetObj = {
	var storage :String;
	var id :Dynamic;
	var partialAr :Array<String>;// list of field to load (TODO : use VPath ?)
}
 
class RetrieveObject extends AControllerProcedure<DbGetObj> {
	
	static public var toto :Sector = null;
	static public var titi :StringMap<Sector> = null;
	
	override public function process( o :DbGetObj ) :Dynamic {
		
		// TODO : deny access on Auth
		var oData = null;
		try{
			var oDatabase = _oController.getDatabase();
			oData = oDatabase.get( o.storage, o.id, o.partialAr != null );//TODO : usee mut get instead
			
			if( o.partialAr != null )
				oDatabase.loadPartial( oData, o.partialAr );
			
		} catch ( e :Dynamic ) {
			trace(CallStack.toString(CallStack.exceptionStack()));
			trace(e);
		}
		return oData;
	}
	
}