package server.rudy.session;

class SetCookie {
    
    var _sKey :String;
    var _sValue :String;
    var _bSecure :Bool;
    var _bHttpOnly :Bool;
    
    public function new( sKey :String, sValue :String ) {
        _sKey = sKey;
        _sValue = sValue;
        _bSecure = false;
        _bHttpOnly = false;
    }
    
    /**
	 * Make cookie only available with HTTPS
	 */
    public function setSecure() {
        _bSecure = true;
    }
    /**
	 * Make cookie inaccessible to client's JS
	 */
    public function setHttpOnly() {
        _bHttpOnly = true;
    }
    
    public function toString() {
       var s = 'Set-Cookie: '+ _sKey+ '='+_sValue;
        if( _bSecure )
        	s += '; Secure';
        if( _bHttpOnly )
            s += '; HttpOnly'; 
        return s;
    }
}
/*
class Singleton {
    static var _mInstance :StringMap<Dynamic> = null;
    
    static function _getMap() {
        if( _mInstance == null ) {
            _mInstance = new StringMap<Dynamic>();
        }
        return _mInstance;
    }
    
	public static function getInst<C>( oKey :Tutu<C> ) :C { 
        var sClassName = Type.getClassName( oClass );
        var m = _getMap().get( sClassName );
        var o = m.get( sClassName );
        if( o == null ) {
            o = _createInstance( oClass );
            m.set( sClassName, o );
        }
            
        return o;
    }
    
    public static function setInst<C>( oKey :Tutu<C>, o :C ) {
        _mInstance.set( oKey, o );
    }
}
*/
class Test {
    static function main() {
        trace("Haxe is great!"+Math.random());
        var s = test(new Toto());
    }
    
    static function test( o :{
  function toString() :String;
} ) {
        return o.toString();
    }
}

class Toto {
    public function new() {
        
    }
    public function toString() {
        return 'hello';
    }
}

class Session<CData> {
    
    var _sId :String;
    var _oData :CData;
    
    public function new( sId :String ) {
        _sId = sId;
        _oData = null;
    }
    
    public function getId() {
        return _sId;
    }
    
    public function getData() {
        return _oData;
    }
    
    public function setData( oData :CData ) {
        _oData = oData;
    }
    

}





