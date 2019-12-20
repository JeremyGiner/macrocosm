package server.rudy;


interface IFunction<CParam,CResult> {
	public function apply( param :CParam ) :CResult;
}

interface IValidator<C> extends IFunction<C,Bool> {
	
}

class VPathProvider {
	public function get( sPath :String ) {
		
	}
}

class FieldAccessor implements IFunction<Dynamic,Dynamic> {
    
    var _sFieldName :String;
    
    public function new( sFieldName :String ) {
        _sFieldName = sFieldName;
    }
    public function apply( o :Dynamic ) {
        if( o == null )
			throw 'parent for path "'+_sFieldName+'" is null';
        //!\ hasField does not work for class method
        var oRes = Reflect.field( o, _sFieldName );
        if( Reflect.isFunction( oRes ) )
            oRes = Reflect.callMethod( o, oRes, [] );
        return oRes;
    }
}

class VPathValidator implements IValidator<Dynamic> {
    public function new() {
        
    }
    public function apply( o :Dynamic ) {
        return true;
    }
}
/*
The available operators are:

    The "/", "//" and "[...]" operators, used in path expressions, as described above.
    A union operator, "|", which forms the union of two node-sets.
    Boolean operators "and" and "or", and a function "not()"
    Arithmetic operators "+", "-", "*", "div" (divide), and "mod"
    Comparison operators "=", "!=", "<", ">", "<=", ">="

The function library includes:

    Functions to manipulate strings: concat(), substring(), contains(), substring-before(), substring-after(), translate(), normalize-space(), string-length()
    Functions to manipulate numbers: sum(), round(), floor(), ceiling()
    Functions to get properties of nodes: name(), local-name(), namespace-uri()
    Functions to get information about the processing context: position(), last()
    Type conversion functions: string(), number(), boolean()

	Support Keys for Maps
*/
class VPathAccessor implements IFunction<Dynamic,Dynamic> {
    
    var _aPath :Array<String>;
    
    public function new( sPath :String ) {
        _aPath = parsePath( sPath );
    }
    
    public function apply( o :Dynamic ) :Dynamic {
        var oRes = o;
        var lRes :List<Dynamic> = null;
        var bIterate = false;
        for( sPathPart in _aPath ){
            
            if( sPathPart == '*')
            if( bIterate == false ) {	// Case: result is a list now
                bIterate = true;
            	lRes = Lambda.list(oRes);
            	continue;
        	} else { // Case: list of list
                lRes = Lambda.map( lRes, function( oRes ) { 
                    return Lambda.list(oRes);
                } );
                lRes = Lambda.flatten( lRes );
                continue;
            }
        
        	if( lRes != null ) {
                
        		var l = new List<Dynamic>();
            	for( o in lRes )
                    l.add(getAccess( o, sPathPart ));
                lRes = l;
                continue;
            }
            	
            // else
            oRes = getAccess( oRes, sPathPart );
    	}
    	if( lRes != null )
            return lRes;
        return oRes;
    }
    
    function getAccess( o :Dynamic, sPathPart :String ) :Dynamic {
		if( o == null )
			throw 'parent for path "'+sPathPart+'" is null';
        var oRes = Reflect.field( o, sPathPart );
        if( Reflect.isFunction( oRes ) )
            oRes = Reflect.callMethod( o, oRes, [] );
        return oRes;
    }
    
    static public function parsePath( sPath :String ) {
        
		// Split
		var a = sPath.split('.');

		// Remove trailling ()
		a = a.map( function( s :String ) { 
			if( s.substr(-2) == '()' ) 
				return s.substring(0, s.length-2); 
			return s; 
		});
        return a;
    }
}

class User {
    var _a :Array<User>;
    var _data :Dynamic;
    
    public function new() {
        _a = [this,this,this];
        _data = {
            type: 'titi',
        };
    }
    public function getName() {
        return 'toto';
    }
    public function getChildAr() {
        return _a;
    }
}

class Test {
    static function main() {
        var oUser = new User();
        
        var a = [1,2,3];
        a.iterator();
        
        trace(Type.getInstanceFields( Array ));
        for( o in a )
            trace(o);
        
        var o1 :Dynamic= {};
        var o2 :Dynamic= {};
        var o= o1 + o2;
        trace(o);
        
        var oAccessor = new VPathAccessor( 'getChildAr.*.getChildAr.*._data.type' );
        trace('acessing : '+ oAccessor.apply(oUser) );
    }
}

