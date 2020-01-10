package entity.worldmap;
import haxe.ds.IntMap;
import haxe.ds.StringMap;
import tool.Tool;
import tool.OpenSimplexNoise;
import entity.worldmap.Tile.CapacityType;

/**
 * ...
 * @author ...
 */
class WorldmapGenerator {
	var _iSeedElevation :Int;
	var _iSeedHumidity :Int;
	
	var _aPerlinElevation :Array<Array<Float>>;
	
//_____________________________________________________________________________
//	Constructor
	
	public function new( iSeedElevation :Int = 2581, iSeedHumidity :Int = 2543 ) {
		_iSeedElevation = iSeedElevation;
		_iSeedHumidity = iSeedHumidity;
	}
	
	
//_____________________________________________________________________________
//	Process

	public function generate() {
		trace('generating map');
		var oWorldmap = new Worldmap();
		oWorldmap.addSector( _generateSector(0, 0) );
		trace('generating map done');
		return oWorldmap;
	}

//_____________________________________________________________________________
//	Sub-routine
	
	public function _generateSector( iSectorX :Int, iSectorY :Int ) :Sector {
		var mTile = new StringMap<Tile>();
		
		// Generate noise
		var mElevation = _generateSectorElevation( iSectorX, iSectorY );
		var mHumidity = _generateSectorHumidity( iSectorX, iSectorY );
		var mNoiseSoil = _generateSectorSoil( iSectorX , iSectorY );
		
		// Generate Tiles
		for ( x in iSectorX * 13...((iSectorX + 1) * 13) ) 
		for ( y in iSectorY * 13...((iSectorY + 1) * 13) ) {
			var sKey = Location.STtoString(x, y);
			mTile.set( sKey, _createTile(
				x, y,
				mElevation.get( sKey ),
				mHumidity.get( sKey ),
				mNoiseSoil.get( sKey )
			) );
		}
		
		return new Sector( iSectorX, iSectorY, mTile );
		
	}
	
	function _createTile( x :Int, y :Int, fPerlinElevation :Float, fPerlinHumidity :Float, fPerlinSoil :Float ) {
		// Convertion [~-0.7;~0.7] -> [-1.0;1.0]
		var fElevation = fPerlinElevation*2;
		
		// Trim
		fElevation = (fElevation > 1)? 1 - (fElevation-1) : fElevation;
		fElevation = (fElevation <-1)? -1 - (fElevation + 1) : fElevation;
		
		// Erosion
		if ( fElevation > 0 )
			fElevation = Math.pow( fElevation, 2 );
		
		var fTemperature = -fElevation + 1;
		var fHumidity = Math.max( 0, Math.min( 1.0, (fPerlinHumidity + 0.4) * 1.5 ) );//TODO: use clamp function
		fPerlinSoil = Math.abs(fPerlinSoil);
		var fVegetation = _getVegetation( fTemperature, fHumidity );
		
		// Natural product
		var mProductType = new IntMap<Int>();
		if ( fElevation > 0 ) {
			// Field
			mProductType.set( cast CapacityType.FIELD, Std.int( 100
					* Tool.filterHigh(fVegetation, 0.0, 0.30)
					* Tool.filterLow(fVegetation, 0.30, 0.70)
			) );
			
			// Forest
			mProductType.set( cast CapacityType.FOREST, Std.int( 100
					* Tool.filterHigh(fVegetation, 0.30, 0.70)
			) );
			
			// Stone deposit
			mProductType.set( cast CapacityType.STONE, Std.int( 100
					* Tool.filterLow(fVegetation, 0.0, 0.2)	// vegetation block mining
					* fPerlinSoil
			) );
			// Iron deposit
			mProductType.set( cast CapacityType.IRON, Std.int( 100
					* Tool.filterLow(fVegetation, 0.0, 0.2)	// vegetation block mining
					* Tool.filterLow(fPerlinSoil, 0.0, 0.2)
			) );
			// Gold deposit
			mProductType.set( cast CapacityType.GOLD, Std.int( 100
					* Tool.filterLow(fVegetation, 0.0, 0.2)	// vegetation block mining
					* Tool.filterHigh(fPerlinSoil, 0.25, 0.3)
					* Tool.filterLow(fPerlinSoil, 0.3, 0.35)
			) );
		} else {
			// Fish deposit
			mProductType.set( cast CapacityType.FISH, Std.int( 100* fPerlinSoil ) );
		}
		
		// Remove zero
		var m = new IntMap<Int>();
		for ( iKey => iValue in mProductType ) {
			if ( iValue != 0 )
				m.set( iKey, iValue );
		}
		mProductType = m;
		/*
		 * TODO
		oTileSouth = isset(this->_aTile[x.':'.(y-1)])?
			this->_aTile[x.':'.(y-1)]:
			null
		;
		*/
		return new Tile(
				x, y,
				fElevation,
				fHumidity,
				fTemperature,
				mProductType
		);
	}
	
	function _generateSectorElevation( iSectorX :Int, iSectorY :Int ) {
		
		return _getNoise(
			_iSeedElevation,
			5,
			0.025,
			169,
			169,
			iSectorX * 169,
			iSectorY * 169
		);
	}
	
	function _generateSectorHumidity( iSectorX :Int, iSectorY :Int ) {
		
		return _getNoise(
			_iSeedHumidity,
			6,
			0.025,
			169,
			169,
			iSectorX * 169,
			iSectorY * 169
		);
	}
	
	function _generateSectorSoil( iSectorX :Int, iSectorY :Int ) {
		
		return _getNoise(
			0,
			1,
			0.5,
			169,
			169,
			iSectorX * 169,
			iSectorY * 169
		);
	}
	
	function _getNoise( 
		iSeed :Int = 53317, 
		iOctaveCount :Int = 5, 
		fFirstFequency :Float = 0.025,
		iWidth :Int = 128,
		iHeight :Int = 128,
		iOffsetX :Int = 0,
		iOffsetY :Int = 0 
	) {
		
		//HxMidpointDisplacement.generateFloatMatrix		
		var aNoise = new Array<OpenSimplexNoise>();
		var aOctave = new Array<Float>();
		var aFreq = new Array<Float>();
		
		// Generate noises using their octaves and frequency
		var fFreq = fFirstFequency;
		for ( i in 0...iOctaveCount ) {
			aNoise.push( OpenSimplexNoise.createBySeed( iSeed + i ) );
			aOctave.push( 1 / (i + 1) );
			aFreq.push( fFreq );
			
			fFreq *= 2;
		}
		
		// Add up all the layers
		var mNoiseValue = new StringMap<Float>();
		for ( x in 0...iWidth )
		for ( y in 0...iHeight ) {
			var sKey = Location.STtoString(x, y);
			var fValue :Float = 0;

			var fOctaveSum :Float = 0;
			for ( i in 0...aNoise.length ) {
				var oNoise = aNoise[i];
				
				fValue += oNoise.getValue3D(
						x * aFreq[i],
						y * aFreq[i],
						169
					) * aOctave[i] 
				;
				
				fOctaveSum += aOctave[i];
			}
			
			fValue /= fOctaveSum;
			
			mNoiseValue.set( sKey, fValue );
		}
		
		return mNoiseValue;
	}
	
	function _getVegetation( fTemp :Float, fHumi :Float ) {
		return 
			Tool.filterHigh( fHumi, 0.25, 1.0 )
			* Tool.filterHigh( fTemp, 0.6, 0.8 )
		;
	}
}

