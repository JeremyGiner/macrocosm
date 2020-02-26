package client.response_body_decoder;
import entity.mapper.ClientMappingInfoProvider;
import sweet.functor.IFunction;
import js.html.XMLHttpRequest;
import haxe.Json;
import sweet.ribbon.RibbonDecoder;
import sweet.ribbon.RibbonStrategy;
import haxe.io.Bytes;
import haxe.io.BytesData;
import js.html.XMLHttpRequestResponseType;

/**
 * ...
 * @author ...
 */
class ResponseBodyRibbon implements IFunction<XMLHttpRequest,Dynamic> {

	var _oDecoder :RibbonDecoder;
	
	public function new() {
		_oDecoder = new RibbonDecoder( new RibbonStrategy( new ClientMappingInfoProvider() ) );
	}
	
	public function apply( oReq :XMLHttpRequest ) {
		//TODO : assert oReq.responseType == XMLHttpRequestResponseType.ARRAYBUFFER;
		if ( oReq.getResponseHeader('Content-Type') != 'application/octet-stream' )
			throw 'invalid content type "'+oReq.getResponseHeader('Content-Type')+'", expecting "application/octet-stream"';
		return _oDecoder.decode( Bytes.ofData(oReq.response) );
	}
	
	static var _oInstance :ResponseBodyRibbon = null;
	
	static public function singleton() {
		
		if ( _oInstance == null )
			_oInstance = new ResponseBodyRibbon();
		return _oInstance;
	}
}