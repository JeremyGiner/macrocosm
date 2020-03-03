package client;
import unveil.Model;
import unveil.loader.LoaderXhrJson;
import unveil.tool.VPathAccessor;
import storo.StoroReference;
import haxe.Json;
import js.html.XMLHttpRequestResponseType;
import client.response_body_decoder.ResponseBodyRibbon;

/**
 * ...
 * @author 
 */
class StoroRefLoader extends LoaderXhrJson {

	var _oModel :Model;
	var _sParentKey :String;
	var _oVPath :VPathAccessor;
	
	public function new( 
		oModel :Model, 
		sParentKey :String, 
		oVPath :VPathAccessor 
	) {
		_oModel = oModel;
		_sParentKey = sParentKey;
		_oVPath = oVPath;
		super('POST','/_game',[],{},new ResponseBodyRibbon(),XMLHttpRequestResponseType.ARRAYBUFFER);
	}
	
	override public function callback(resolve:String->Void, reject:Dynamic->Void) {
		
		_oModel.loadEntity( _sParentKey ).then(function(o:Dynamic){
			var o = _oModel.getEntity( _sParentKey );
			
			if ( o == null ) {
				resolve(null);
				return;
			}
			
			var oRef :StoroReference<Dynamic> = _oVPath.apply( o );
			if ( oRef == null ) {
				resolve(null);
				return;
			}
			
			if ( !Std.is(oRef, StoroReference) ) {
				reject('Invalid path');// TODO: improve message
				return;
			}
			
			_sBody = Json.stringify( {
				procedure: "server.controller.procedure.RetrieveObject",
				param: {
					id: oRef.getEntityId(), 
					storage: oRef.getStorageId(),
				}
				
			} );
			
			_f(resolve,reject);
		});
	}
	
	public function _f(resolve:String->Void, reject:Dynamic->Void) {
		super.callback(resolve, reject);
	}
}