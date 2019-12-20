package server.rudy.session;
import rudyhh.Request;
import rudyhh.Response;

/**
 * ...
 * @author 
 */
class SessionManager<CData> {
    
    var _oRequest :Request;
    var _oRepository :ISessionRepository;
    var _oResponse :Response;
    var _oIdGenerator :SessionIdGenerator;
    
    var _sId :Null<String>;
    
    static var COOKIE_KEY = 'SESSID';
    
    public function new( 
        oRequest :Request, 
        oResponse :Response,
        sStoragePath :String,
        oRepository :ISessionRepository = null
    ) {
        _oRequest = oRequest;
        _oResponse = oResponse;
        _oRepository = oRepository == null ? 
            new SessionRepository( sStoragePath ) :
            oRepository
        ;
        _oIdGenerator = new SessionIdGenerator( _oRepository );
        
        _sId = null;
    }
    
    public function getSession() :Session<CData> {
    	var s = _getId();
        
        // Check length validity
        if( s != null && s.length != 24 ) {
            Singleton.getInst(Logger).logWarning('invalid SESSID found : "'+(s.length<200?s:(s.substr(0,200)+'...'))+'"');
            s = null;
        }
        // Get active session
        var o = _oRepository.get( s );
        
        // Case : no current session active, create one
        if( o == null )
            return _createSession();
        
        return o;
        
    }
    
    public function destroySession() {
        _oRepository.destroy( _getId() );
    }
    
    /**
	 * return current session id
	 */
    function _getId() {
        if( _sId == null )
            _sId = _oRequest.getCookie(COOKIE_KEY);
        return _sId;
    }
    
    function _createSession() {
        var o = new Session<CData>( _oIdGenerator.generate( _oRequest.getPeerInfo() ) );
        
        _oResponse.setHeader('Set-Cookie',new SetCookie(COOKIE_KEY, o.getId()));
        _oRepository.save( o );
        _sId = o.getId();
        return o;
    }
}

class SessionIdGenerator {
    
    var _oRepo :SessionRepository;
    
    public function new( oRepo :SessionRepository ) {
        _oRepo = oRepo;
    }
    
    public function generate( sPeerInfo :String ) {
        var s = '';
        var i = 0;
        do {
            s = 
                sPeerInfo 
                + Date.now().getTime()
                + Math.random()
            ;
            s = haxe.crypto.Sha1( s );
            i++;
            
            if( i > 100 )
                throw '100th collision with ID:"'+s+'"';
        
        // check for collision
        } while( _oRepo.get( s ) != null );
        
        
        return s;
    }
}