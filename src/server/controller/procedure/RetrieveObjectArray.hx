package server.controller.procedure;
import haxe.Json;
import haxe.Serializer;
import entity.worldmap.Worldmap;
import entity.worldmap.Sector;
import haxe.ds.StringMap;
import storo.core.Storage;

import haxe.CallStack;

/**
 * ...
 * @author 
 */

 typedef DbGetObjAr = {
	var keyAr :Array<Dynamic>;
	var index :String;
	var partialAr :Array<String>;// list of field to load (TODO : use VPath ?)
}
 
class RetrieveObjectArray extends AControllerProcedure<DbGetObjAr> {
	
	override public function process( oParam :DbGetObjAr ) :Dynamic {
		var oDatabase = _oController.getDatabase();
		
		
		var oStorage :Storage<Dynamic,Dynamic> = null;
		
			
		// Case index
		var a = oParam.index.split('#');
		if ( a.lenght != 2 )
			throw 'invalid index path :"' + s + '" ';// todo : turn into user message
		
		oStorage = oDatabase.getStorage( a[0] );
		if ( oStorage == null )
			throw 'storage "' + a[0] + '" not found';
		var oPrimary = oStorage.getDescriptor().getPrimaryIndex();
		var oIndexer = (a[1] == '' ) ? 
			null : 
			oStorage.getDescriptor().getIndexer(a[1])
		;
		
		// Intersect with current list
		var lEntityId = new List<Dynamic>();
		for ( v in keyAr ) {
			lEntityId.push( oIndexer.get(v) );
		}
		
		var aId = oIndexer == null ? param.keyAr : Lambda.array( lEntityId );
		
		// Load entities
		return oStorage.getAr( aId );
		
		//if( o.partialAr != null )
			//oDatabase.loadPartial( oData, o.partialAr );
	}
	
}