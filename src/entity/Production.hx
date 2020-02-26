package entity;

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
	


	
}