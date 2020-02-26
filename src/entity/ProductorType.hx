package entity;
import entity.part.TileCapacityRequirement;

/**
 * ...
 * @author GINER Jeremy
 */
class ProductorType extends Entity {

	var _iValue :Int;
	var _sDesciption :String;
	var _aProd :Array<ProductionType>;
	var _iDeedCost :Int;
	var _oTileCapacityRequirement :TileCapacityRequirement;
	
//_________________________________________________________________________
//	Constructor
	
	public function new( 
		iCategory :Int,//TODO
		sLabel :String, 
		iValue :Int,
		iDeedCost :Int = 1,
		sDesciption :String,
		aProd :Array<ProductionType> = null,
		oTileCapacityRequirement :TileCapacityRequirement = null
	) {
		super(sLabel);
		//Macro.ParamAssign();
		_iValue = iValue;
		_sDesciption = sDesciption;
		_aProd = aProd;
		_iDeedCost = iDeedCost;
		_oTileCapacityRequirement = oTileCapacityRequirement;
	}
	
//_________________________________________________________________________
//	Accessor
	
	public function getContractCost() {
		return _iDeedCost;
	}
	
	public function getBaseCost() {
		return _iValue;
	}

	public function getProductionType() {
		return _aProd;
	}
	
}

