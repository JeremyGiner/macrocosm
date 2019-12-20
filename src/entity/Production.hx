package entity;
import storo.core.Database;
import tool.Macro;

/**
 * ...
 * @author GINER Jeremy
 */
class Production extends Entity {
	var _oOwner :Productor;
	var _oType :ProductionType;
	var _oInputLocation :Location;
	var _oOutputLocation :Location;
	var _iLevel :Int;
	
	// calculated
	//TODO
	var _fRatioMax :Float;
	// ? _aInput :Array<Production>;
	// ? _aOutput :Array<Production>;
	
	public function new( 
		oOwner :Productor, 
		oType :ProductionType, 
		oInputLocation :Location, 
		oOuputLocation :Location 
	) {
		super('Some ' + _oType._sLabel);
		_oOwner = oOwner;
		_oType = oType;
		_oInputLocation = oInputLocation;
		_oOutputLocation = oOuputLocation;
		_iLevel = 1;
		_fRatioMax = 0;
	}
	
//_____________________________________________________________________________
//	Accessor

	public function getInputLocation() {
		return _oInputLocation;
	}
	
	public function getOutputLocation() {
		return _oOutputLocation;
	}
	
	public function getType() {
		return _oType;
	}

	public function getLevel() {
		return _iLevel;
	}
	
	public function getRatio() {
		return _fRatioMax;
	}
	
//_____________________________________________________________________________
//	Modifier
	
	public function upgrade() {
		_iLevel++;
	}
	
	public function downgrade() {
		_iLevel--;
	}
	

//_____________________________________________________________________________
//	On Production create

	public function observeCreation( oCreated :Dynamic ) {
		
		if ( ! Std.is( oCreated, Production ) )
			return;
		
		updateRatio( oCreated );
	}

	public function updateRatio( oCreated :Dynamic ) {
		
		// ignore below, 
		// on commit, if ratio changed (check a flag) use pathfinder to iterate to each production impacted and update their ratio (assume struture to be tree and not network) 
		
		// get all prodcution
		// at output location 
		// and with input type with product type == output poduct type
		// and with same owner.owner
		var oDatabase :Database = null;
		oDatabase.getStorage('Default');
		//get list production with location == this.location using entity.Production indexed by location
		//inner join list production with product input type == output poduct type using entity.Production indexed by input product type
		//inner join list same owner.owner using Production indexed by owner.owner
		
		// persist
		oDatabase.persist( this );
	}
	
}