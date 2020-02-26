package client.view;
import client.response_body_decoder.ResponseBodyRibbon;
import haxe.DynamicAccess;
import haxe.ds.IntMap;
import haxe.ds.StringMap;
import sweet.functor.builder.IBuilder;
import tool.Tool;
import entity.worldmap.Tile.CapacityType;
import js.html.XMLHttpRequest;
import entity.worldmap.Tile;
import entity.worldmap.Sector;
import entity.worldmap.Worldmap;

/**
 * ...
 * @author ...
 */
class WorldmapViewBuilder extends ResponseBodyRibbon {

	public function new() {
		super();
	}
	
	override public function apply( oReq :XMLHttpRequest ) {
		var oWorldmap :Worldmap = cast super.apply( oReq );
		
		return create( oWorldmap );
	}
	
	public function create( o :Worldmap = null ) :Dynamic {
		var oView :{sectorAr:IntMap<IntMap<Dynamic>>,link :String} = {
			sectorAr: new IntMap<IntMap<Dynamic>>(),
			link: null
		};
		//oView.sector 
		// TODO
		var oWorldmap = o;
		for ( oSector in oWorldmap.getSectorMap() ) {
			if ( !oView.sectorAr.exists(oSector.getY()) ) 
				oView.sectorAr.set(oSector.getY(),new IntMap<Dynamic>());
			oView.sectorAr.get(oSector.getY()).set(oSector.getX(), getSectorView(oSector));
		}
		return oView;
		/* 
		worldmap
			sectorAr [y][x]
				locationAr[y][x]
					city int pop size
					pawn bool
					color string #
				
			link
		*/
	}
	
	public function getSectorView( oSector :Sector ) {
		var aTile = new IntMap<IntMap<Dynamic>>();
		for ( oTile in oSector.getTileMap() ) {
			if ( !aTile.exists(oTile.getY()) ) 
				aTile.set(oTile.getY(),new IntMap<Dynamic>());
			aTile.get(oTile.getY()).set( oTile.getX(), createTileView(oTile));
		}
		return {
			locationAr: aTile,
		}
	}
	
	public function createTileView( oTile :Tile ) {
		return {
			city: null,
			pawn: null,
			color: getColorHex( getRGB( oTile ) ),
		};
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
		
		var aColor = [0,0,0];
		
		// Case : sea
		if( fElevation <= 0 ) {
			
			aColor = _interpolateColor( 
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
		
		
		//fVegetation = fVegetation *fHumi;
		
		// Elevation
		aColor = _interpolateColor(
			[233, 206, 179],
			[134, 120, 100],//[108,97,79],
			Tool.filterHigh(fElevation, 0, 0.5)
		);
		
		// Vegetation
		var iField = oTile.getCapacity( cast CapacityType.FIELD);
		if( iField != null )
			aColor = _interpolateColor(
				aColor, 
				[94, 121, 66], 
				iField / 100
			);
		
		//forest
		var iForest = oTile.getCapacity( cast CapacityType.FOREST);
		if( iForest != null )
		aColor = _interpolateColor(
			aColor,
			[65, 98, 51],
			iForest / 100
		);
		
		// Snow
		aColor = _interpolateColor(
			[255,255,255], 
			aColor, 
			Tool.filterHigh(
				fTemp, 
				0.1, 0.5 )
		);
		
		// Shadow
		/*
		 * TODO
		if( this->_oSouthTile != null )
		aColor = this->_interpolateColor(
			aColor,
			[0, 0, 0],
			max( 0, this->_oSouthTile->_fElevation - this->_fElevation ) *1.5
		);
		*/
		return aColor;
	}
	public function getColorHex( aRGB ) {
		return StringTools.hex(aRGB[0]) + StringTools.hex(aRGB[1]) + StringTools.hex(aRGB[2]);
	}
	
	function _interpolateColor( aAlpha :Array<Int>, aOmega :Array<Int>, fPercent :Float ) {
		
		if( fPercent > 1 )
			throw '!!';
		return [
			Std.int( _interpolate(
				aAlpha[0],
				aOmega[0], 
				fPercent
			) ),
			Std.int( _interpolate(
				aAlpha[1],
				aOmega[1], 
				fPercent
			) ),
			Std.int( _interpolate(
				aAlpha[2],
				aOmega[2], 
				fPercent
			) )
		];
	}
	
	function _interpolate( iAlpha :Int, iOmega :Int, fPercent :Float ) {
		var iDelta = iOmega - iAlpha;
		return iAlpha + iDelta * fPercent;
	}
}