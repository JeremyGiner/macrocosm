package server.rudy;
import rudy.Response in ResponseBase;

/**
 * ...
 * @author 
 */
class Response extends ResponseBase {

	var _oBody :Dynamic;
	
//_____________________________________________________________________________
//	Constructor
	
	public function new( 
		iCode :Int = 200, 
		sReasonPhrase :String = 'OK',
		oBody :Dynamic = ""
	) {
		_oBody = oBody;
		
		_sVersion = 'HTTP/1.1';
		_iCode = iCode;
		_sReasonPhrase = sReasonPhrase;
		_mHeader = new StringMap();
	}
	
//_____________________________________________________________________________
//	Process
	
	public function toString() {
		return _sVersion + ' ' + _iCode + ' ' + _sReasonPhrase + CRLF
			+ _printHeader()
			+ CRLF
			+ _sBody
		;
	}
	
}