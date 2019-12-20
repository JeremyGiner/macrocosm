package entity;
import tool.Macro;

/**
 * ...
 * @author GINER Jeremy
 */
class ProductionType extends Entity {
	
	var _aOut :Array<ProductType>;
	//var _aOutQuantity :Array<Int>;
	var _aInput :Array<ProductType>;
	var _aInputQuantity :Array<Int>;
	
//_____________________________________________________________________________
//	Constructor
	
	public function new( 
		sLabel :String, 
		aInput :Array<ProductType>, 
		aInputQuantity :Array<Int>,
		oProductType :ProductType, 
		iWhatever :Int = 1
	) {
		super( sLabel );
		
		_aOut = [oProductType];
		_aInput = aInput;
		_aInputQuantity = aInputQuantity;
	}
	
	static public function createSimple( sLabel :String, oIn :ProductType, oOut :ProductType ) {
		return new ProductionType( sLabel, 
			[oIn], [1],
			oOut, 1 
		);
	}
	
	static public function createCollector( sLabel :String, oOut :ProductType ) {
		return new ProductionType( sLabel, 
			[], [],
			oOut, 1 
		);
	}
	
	static public function createTransporter( sLabel :String, oOut :ProductType ) {
		return new ProductionType( sLabel, 
			[oOut], [1],
			oOut, 1 
		);
	}
	
//_____________________________________________________________________________
//	Accessor
	
	public function getProductType() {
		return _aOut[0];
	}
	
	public function getOutputQuantity() {
		return 1;
	}
	
	public function getInputTypeAr() {
		return _aInput;
	}
	
	public function getIntputQuantityAr() {
		return _aInputQuantity;
	}
}