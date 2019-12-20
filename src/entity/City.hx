package entity;

/**
 * ...
 * @author GINER Jeremy
 */
class City extends Pawn {

	var _aDemand :Array<Demand>;//TODO: turn into map ?
	var _oPopulation :Population;
	//var _oRuler
	// var influence
	
	public function new( oLocation :Location ) {
		super(
			null,
			[oLocation]
		);
	}
	
	public function getPopulation() {
		return _oPopulation;
	}
	
	public function getDemandAr() {
		return _aDemand;
	}
	
}