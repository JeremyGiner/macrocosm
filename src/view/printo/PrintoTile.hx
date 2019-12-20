package view.printo;
import entity.Tile;

/**
 * ...
 * @author GINER Jeremy
 */
class PrintoTile {
	
	public function new() {
		
	}
	
	public function print( oTile :Tile ){
		
	}
	
	public function getRGB( oTile :Tile ) {
		
		// TEST
		/*
		i = 35;
		f = isset(this->_aRessourceSource[i])? this->_aRessourceSource[i]: 0;
		aColor = this->_interpolateColor(
				[0,0,0],
				[255,255,255],
				f/100
		);
		return aColor;
		*/
		
		var fTemp = oTile.getTemperature();
		var fElevation = oTile.getElevation();
		var fHumi = oTile.getHumidity();
		
		// Case : sea
		if( fElevation <= 0 ) {
			
			aColor = this->_interpolateColor( 
				[34,86,107], // Light blue
				[19,64,85], // Deep blue
				-fElevation
			);
			/*
			// Shadow
			if( this->_oSouthTile != null )
				aColor = this->_interpolateColor(
					aColor,
					[0, 0, 0],
					max( 0, 
						this->_oSouthTile->_fElevation - this->_fElevation 
					) * 0.8
				);
			*/
			return aColor;
		}
		
		//fElevation = (fElevation-0.5) * 2;
		//fElevation = fElevation * 10;
		//fElevation = ( fElevation * fElevation ) / 100;
		
		// Filter function x=0.5 top
		i = 33;
		fVegetation = isset(this->_aRessourceSource[i])? this->_aRessourceSource[i]: 0;
		fVegetation /= 100;
		
		i = 34;
		fForest =  isset(this->_aRessourceSource[i])? this->_aRessourceSource[i]: 0;
		fForest /= 100;
		
		i = 37;
		fStone =  isset(this->_aRessourceSource[i])? this->_aRessourceSource[i]: 0;
		fStone /= 100;
		
		
		//fVegetation = fVegetation *fHumi;
		
		// Elevation
		aColor = this->_interpolateColor(
			[233, 206, 179],
			[134, 120, 100],//[108,97,79],
			F::filterHigh(this->_fElevation, 0, 0.5)
		);
		
		// Vegetation
		aColor = this->_interpolateColor(
			aColor, 
			[94, 121, 66], 
			fVegetation
		);
		
		//forest
		aColor = this->_interpolateColor(
			aColor,
			[65, 98, 51],
			fForest
		);
		
		// Snow
		aColor = this->_interpolateColor(
			[255,255,255], 
			aColor, 
			this->_filterHigh(
				this->_fTemperature, 
				0.1, 0.5 )
		);
		
		// Shadow
		if( this->_oSouthTile != null )
		aColor = this->_interpolateColor(
			aColor,
			[0, 0, 0],
			max( 0, this->_oSouthTile->_fElevation - this->_fElevation ) *1.5
		);
		
		return aColor;
	}
		/**
	 * @todo move to view
	 * @return string
	 */
	public function getColorHex() {
		$aRGB = $this->getColorRGB();
		return dechex($aRGB[0]).dechex($aRGB[1]).dechex($aRGB[2]);
	}
	
	private function _interpolateColor( array $aAlpha, array $aOmega, $fPercent ) {
		
		if( $fPercent > 1 )
			throw new \Exception();
		return [
			(int)$this->_interpolate(
				$aAlpha[0],
				$aOmega[0], 
				$fPercent
			),
			(int)$this->_interpolate(
				$aAlpha[1],
				$aOmega[1], 
				$fPercent
			),
			(int)$this->_interpolate(
				$aAlpha[2],
				$aOmega[2], 
				$fPercent
			)
		];
	}
}