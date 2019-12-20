package server.rudy;



interface IBiFunction<CParam0,CParam1,CResult> {
	public function apply( param0 :CParam0, param1 :CParam1 ) :CResult;
}


class IntAscComparator  {

	public function new() {
		trace('hello');
	}
	
	public function apply( a :Int, b :Int) {
        trace('apply');
		if ( a == b )
			return 0;
		return a < b ? -1 : 1;
	}
	
}

class ListNode<T> {
	public var item:T;
	public var next:ListNode<T>;
	public function new(item:T, next:ListNode<T>) {
		this.item = item;
		this.next = next;
	}
	@:extern public inline static function create<T>(item:T, next:ListNode<T>):ListNode<T> {
		return new ListNode(item, next);
	}
}

class ListSorted<T> {

	var h : ListNode<T>;
	var q : ListNode<T>;
   	var _oComparator :IBiFunction<T,T,Int>;
    
    /**
		The length of `this` List.
	**/
	public var length(default,null) : Int;
    
    /**
		Creates a new empty list.
	**/
    public function new( oComparator :IntAscComparator ) {
		length = 0;
        _oComparator = cast oComparator;
    }
    
    public function insertSort( o :T ) {
        trace('inserting '+o+'____________________________');
        var oNode = ListNode.create(o, null);
        
        // Case : empty
        if( this.h == null ) {
        	this.h = oNode; 
        	this.q = oNode; 
            this.length++;
            return;
        }
        
        // Case : insert ahead
        var iCompare = _oComparator.apply( this.h.item, o );
        if( iCompare > 0 ) {
         	// Insert before current
            oNode.next = this.h;
            this.h = oNode; 
            this.length++;
            return;
        }
           
            var i = 0;
        var oCurrentNode = this.h;
        var oNextNode = this.h.next;
        while( oNextNode != null ) {
            trace('compare '+o+ ' to ' +oNextNode.item+' in '+this);
            var iCompare = _oComparator.apply( oNextNode.item, o );
             // current item >= o
            if( iCompare >= 0 ) {
                // Insert after current
                oNode.next = oCurrentNode.next;
                oCurrentNode.next = oNode;
                this.length++;
                return;
            // current item < o
            } //else if( iCompare < 0 ) {
                i++;
                 if( i > 200)
                     throw 'inifinite loop';
                oCurrentNode = oCurrentNode.next;
                oNextNode = oCurrentNode.next;
                continue;
           
           // }
               
                   
                  
        }
            
        // Case last
        this.q.next = oNode;     
        this.q = oNode; 
        this.length++;
    }

	/**
		Returns the first element of `this` List, or null if no elements exist.
		This function does not modify `this` List.
	**/
	public function first() : Null<T> {
		return if( h == null ) null else h.item;
	}

	/**
		Returns the last element of `this` List, or null if no elements exist.
		This function does not modify `this` List.
	**/
	public function last() : Null<T> {
		return if( q == null ) null else q.item;
	}


	/**
		Returns the first element of `this` List, or null if no elements exist.
		The element is removed from `this` List.
	**/
	public function pop() : Null<T> {
		if( h == null )
			return null;
		var x = h.item;
		h = h.next;
		if( h == null )
			q = null;
		length--;
		return x;
	}

	/**
		Tells if `this` List is empty.
	**/
	public function isEmpty() : Bool {
		return (h == null);
	}

	/**
		Empties `this` List.
		This function does not traverse the elements, but simply sets the
		internal references to null and `this.length` to 0.
	**/
	public function clear() : Void {
		h = null;
		q = null;
		length = 0;
	}

	/**
		Removes the first occurrence of `v` in `this` List.
		If `v` is found by checking standard equality, it is removed from `this`
		List and the function returns true.
		Otherwise, false is returned.
	**/
	public function remove( v : T ) : Bool {
		var prev:ListNode<T> = null;
		var l = h;
		while( l != null ) {
			if( l.item == v ) {
				if( prev == null )
					h = l.next;
				else
					prev.next = l.next;
				if( q == l )
					q = prev;
				length--;
				return true;
			}
			prev = l;
			l = l.next;
		}
		return false;
	}

	/**
		Returns an iterator on the elements of the list.
	**/
	public inline function iterator() : ListIterator<T> {
		return new ListIterator<T>(h);
	}

	/**
		Returns a string representation of `this` List.
		The result is enclosed in { } with the individual elements being
		separated by a comma.
	**/
	public function toString() {
		var s = new StringBuf();
		var first = true;
		var l = h;
		s.add("{");
		while( l != null ) {
            
			if( first )
				first = false;
			else
				s.add(", ");
			s.add(Std.string(l.item));
			l = l.next;
            
		}
		s.add("}");
		return s.toString();
	}

	/**
		Returns a string representation of `this` List, with `sep` separating
		each element.
	**/
	public function join(sep : String) {
		var s = new StringBuf();
		var first = true;
		var l = h;
		while( l != null ) {
			if( first )
				first = false;
			else
				s.add(sep);
			s.add(l.item);
			l = l.next;
		}
		return s.toString();
	}

	/**
		Returns a list filtered with `f`. The returned list will contain all
		elements for which `f(x) == true`.
	**/
	public function filter( f : T -> Bool ) {
		var l2 = new List();
		var l = h;
		while( l != null ) {
			var v = l.item;
			l = l.next;
			if( f(v) )
				l2.add(v);
		}
		return l2;
	}

	/**
		Returns a new list where all elements have been converted by the
		function `f`.
	**/
	public function map<X>(f : T -> X) : List<X> {
		var b = new List();
		var l = h;
		while( l != null ) {
			var v = l.item;
			l = l.next;
			b.add(f(v));
		}
		return b;
	}
}





private class ListIterator<T> {
	var head:ListNode<T>;

	public inline function new(head:ListNode<T>) {
		this.head = head;
	}

	public inline function hasNext():Bool {
		return head != null;
	}

	public inline function next():T {
		var val = head.item;
		head = head.next;
		return val;
	}
}



//_______________________________________________________

class Test {
    static function main() {
        
        var oCmp = new IntAscComparator();
        oCmp.apply( 0, 1 );//counteract DCE
        var l = new ListSorted<Int>( oCmp );
        l.insertSort( 5 );
        l.insertSort( 4 );
        l.insertSort( 2 );
        l.insertSort( 3 );
        
        
        trace("Haxe is great! "+l+" "+l.length);
    }
}


