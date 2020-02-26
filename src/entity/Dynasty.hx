package entity;
import haxe.ds.IntMap;
import haxe.ds.ListSort;

using Lambda;


/**
 * ...
 * @author GINER Jeremy
 */
class Dynasty extends Entity {

	var _iCredit :Int;
	var _iContractMax :Int;
	
	var _iLeaderIndex :Int; // Head of the dynasty
	
	var _aCharacter :Array<Character>; // List of followers
	
	
	// ? house (the building)
	
	//__________________
	// Calculated
	
	var _mIncomeFlow :IntMap<IncomeFlow>;
	var _iContractCount :Int;
	var _iIncome :Int;
	
//_________________________________________________________________________
// Constructor
	
	public function new( sLabel ) {
		super( sLabel );
		
		_iCredit = 100;
		_iContractMax = 3;
		
		_mIncomeFlow = new IntMap<IncomeFlow>();
		_iContractCount = 0;
		_iIncome = 0;
		throw 'TODO';
	}
	
//_________________________________________________________________________
// Accessor

	public function getCredit() {
		return _iCredit;
	}
	
	public function getLeader() {
		return _aCharacter[_iLeaderIndex];
	}
	public function getCharacterAr() {
		return _aCharacter;
	}
	
	public function getAvailableContract() {
		return _iContractCount - _iContractMax;
	}

//_________________________________________________________________________
// Calculated
	
	public function getMaleSortedbyAgeInc() {
		var a = new List<Character>();
		
		// TODO : use filter?
		for ( oCharacter in _aCharacter ) {
			if ( oCharacter.getBody().getSex() != Character.Sex.Male )
				continue;
			a.add( oCharacter );
			
		}
		
		var ar = a.array();
		ar.sort( function(oCharater1 :Character, oCharacter2 :Character ) {
			return oCharater1.getCreated() - oCharacter2.getCreated();
		} );
		a = ar.list();
		return a;
	}
	
	public function getFemaleSortedByAgeDesc() {
		var a = new List<Character>();
		
		// TODO : use filter?
		for ( oCharacter in _aCharacter ) {
			if ( oCharacter.getBody().getSex() != Character.Sex.Female )
				continue;
			a.add( oCharacter );
			
		}
		
		var ar = a.array();
		ar.sort( function(oCharater1 :Character, oCharacter2 :Character ) {
			return oCharacter2.getCreated() - oCharater1.getCreated();
		} );
		a = ar.list();
		
		return a;
	}
	
//_________________________________________________________________________
// Modifier
	
	public function addCredit( iDelta :Int ) {
		_iCredit += iDelta; 
	}

	public function addCharacter( oCharacter :Character ) {
		_aCharacter.push( oCharacter );
	}
	
	public function incContractMax() {
		_iContractMax++;
	}
	
	//public function addIncomeFlow( iId :Int ) {
		//var oCharge = _mIncomeFlow.get( iId );
		//
		//if ( oCharge == null )
			//_mIncomeFlow.set( iId, new IncomeFlow( TODO get chartype by id ) );
		////else
		//
		//oCharge.increment();
		//
		//incomeUpdate();
	//}
	
	public function removeIncomeFlow( iId :Int  ) {
		
		var oCharge = _mIncomeFlow.get( iId );
		
		if ( oCharge == null )
			throw 'cannot remove charge #'+iId;
		
		if ( oCharge.getCount() == 1 ) 
			_mIncomeFlow.remove( iId );
		oCharge.decrement();
		
		incomeUpdate();
	}
	
	/**
	 * update on : 
	 * - owned pawn grade
	 * - 
	 */
	public function contractCountUpdate() {
		/*
# JOIN contract owned by player
LEFT JOIN (
	SELECT
		 pawn.player_id,
		 IFNULL(SUM(pawn.grade), 0) as value
	FROM pawn
	JOIN pawntype ON pawntype.id = pawn.type_id 
	GROUP BY pawn.player_id
) as tcontract ON tcontract.player_id = player.id
*/
	}
	
	/**
	 *  update on : 
	 *  - 
	 */
	public function incomeUpdate() {
		
		_iIncome = 0;
		for ( o in _mIncomeFlow )
			_iIncome += o.getType().getValue();
	}
}


/**
 * ...
 * @author GINER Jeremy
 */
class IncomeFlow {
	
	var _oType :IncomeFlowType;
	var _iCount :Int;
	
	public function new( oType ) {
		_oType = oType;
		_iCount = 1;
	}
	
	public function getType() {
		return _oType;
	}
	
	public function getCount() {
		return _iCount;
	}
	
	
	public function decrement() {
		_iCount--;
	}
	public function increment() {
		_iCount++;
	}
}

/**
 * ...
 * @author GINER Jeremy
 */
class IncomeFlowType extends Entity {
	
	var _iValue :Int;
	
	public function new( sLabel :String, iValue :Int ) {
		super( sLabel );
		_iValue = iValue;
	}
	
	public function getValue() {
		return _iValue;
	}
}
