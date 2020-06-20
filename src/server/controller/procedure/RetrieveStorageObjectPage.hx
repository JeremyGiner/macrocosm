package server.controller.procedure;
import haxe.Json;
import haxe.Serializer;
import haxe.ds.StringMap;
import storo.core.Storage;

/**
 * ...
 * @author 
 */

 typedef DbGetObjPage = {
	var storage :String;
	var page :Int;
	var count :Int;
}
 
class RetrieveStorageObjectPage extends AControllerProcedure<DbGetObjPage> {
	
	override public function process( oParam :DbGetObjPage ) :Dynamic {
		var oDatabase = _oController.getDatabase();
		
		// Get Storage
		var oStorage :Storage<Dynamic,Dynamic> = null;
		oStorage = oDatabase.getStorage( oParam.storage );
		if ( oStorage == null )
			throw 'storage "' + oParam.storage + '" not found';
		
		// Get object array
		var aRes = new Array<Dynamic>();
		
		var oIndexer = oStorage.getDescriptor().getPrimaryIndex();
		for ( oKey in oIndexer.keys() ) {
			
			// TODO : use page to offset iteration
			
			aRes.push( oStorage.get(oKey,true) );
			
			if ( aRes.length == oParam.count )
				break;
		}
		
		return aRes;
	}
	
}