package server.rudy.session;
import haxe.crypto.Md5;
import rudyhh.Request;
import rudyhh.Response;

/**
 * ...
 * @author 
 */
class SessionManager<CData> {
    
    var _oRequest :Request;
    var _oResponse :Response;
    var _oRepository :ISessionRepository;
    var _oIdGenerator :SessionIdGenerator;
    
    var _sId :Null<String>;
	var _oSession :Session<CData>;
    
    static var COOKIE_KEY = 'SESSID';
	
//_____________________________________________________________________________
// Constructor
    
    public function new( 
        sStoragePath :String,
        oRepository :ISessionRepository = null
    ) {
        _oRepository = oRepository == null ? 
            new SessionRepository( sStoragePath ) :
            oRepository
        ;
        _oIdGenerator = new SessionIdGenerator( _oRepository );
        
        _sId = null;
		_oSession = null;
    }
//_____________________________________________________________________________
// Accessor
    
    public function getSession() :Session<CData> {
		
		// Load from cache
		if ( _oSession != null )
			return _oSession;
		
        // Get active session
		var s = _sId;
		if ( s == null )
			return null;
        _oSession = cast _oRepository.load( s );
        
        // Case : no current session active, create one
        if( _oSession == null )
            _oSession = _createSession();
		
        return _oSession;
        
    }
	
	public function test() {
		return _oSession;
	}
    
    public function destroySession() {
        _oRepository.destroy( _sId );
    }
    
//_____________________________________________________________________________
// Processs

	public function processRequest( oRequest :Request ) {
		
		_sId = _getId( oRequest );
		_oSession = null;
	}
	
	
	public function processResponse( oResponse :Response ) {
		if( _oSession == null && _sId == null )
			throw 'Trying to set a response without contextual session';
		oResponse.addCookie(COOKIE_KEY, _sId, true);//TODO: only do it once
		if( _oSession != null )
			_oRepository.save( _oSession );
	}
	
//_____________________________________________________________________________
// Subroutine
	
    /**
	 * return current session id
	 */
    function _getId( oRequest :Request ) {
		var iId :String = null;
        if( iId == null )
            iId = oRequest.getCookie(COOKIE_KEY);// Cookie: yummy_cookie=choco; tasty_cookie=strawberry
		if ( iId == null ) 
			iId = _oIdGenerator.generate( oRequest );
        return iId;
    }
    
    function _createSession() {
        var o = new Session<CData>( _sId );
        _oRepository.save( o ); // necessary?
		
        return o;
    }
}

class SessionIdGenerator {
    
    var _oRepo :ISessionRepository;
    
    public function new( oRepo :ISessionRepository ) {
        _oRepo = oRepo;
    }
    
    public function generate( oRequest :Request ) {
        var s = '';
        var i = 0;
        do {
            s = 
                Date.now().getTime()
                + ':' + Math.random()
            ;
            s = haxe.crypto.Sha1.encode( s );
            i++;
            
            if( i > 100 )
                throw '100th collision with ID:"'+s+'"';
        
        // check for collision
        } while( _oRepo.exist( s ) );
        
        
        return s;
    }
}