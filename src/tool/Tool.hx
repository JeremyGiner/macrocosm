package tool;

/**
 * ...
 * @author GINER Jeremy
 */
class Tool {

	public static function filterLow( f :Float, fThreshold0 :Float, fThreshold1 :Float ) :Float {
		if( f >= fThreshold1 )
			return 0;
		if( f <= fThreshold0 )
			return 1;
		var fSlope = (0-1) / (fThreshold1 - fThreshold0);
		return f * fSlope - fSlope*fThreshold1;
	}
	
	public static function filterHigh( f :Float, fThreshold0 :Float, fThreshold1 :Float ) :Float {
		if( f >= fThreshold1 )
			return 1;
		if( f <= fThreshold0 )
			return 0;
		var fSlope = (1-0) / (fThreshold1 - fThreshold0);
		return f * fSlope - fSlope*fThreshold0;
	}
	
	public static function interpolate( iAlpha :Int, iOmega :Int, fPercent :Float ) {
		return iAlpha + ( iOmega - iAlpha ) * fPercent;
	}
	
	//TODO: mose to number tool
	/**
	 * 
	 * @param float value
	 * @param float min included
	 * @param float max excluded
	 * @throws \Exception
	 * @return number
	 */
	public static function circular( value :Float, min :Float, max :Float ) {
		if( min != 0 )
			throw 'Not implemented yet';
		if( min >= max )
			throw 'Invalid values';
		return value - Std.int( value/ max ) * max;
	}
	/**
	 * 
	 * @param float value
	 * @param float min included
	 * @param float max included
	 * @return float
	 */
	public static function clamp( value :Float, min :Float, max :Float ) {
		if( value < min )
			return min;
		if( value > max )
			return max;
		return value;
	}
	
	/**
	 * 
	 * @param float value
	 * @param float min included
	 * @param float max included
	 * @return boolean
	 */
	public static function isBetween( value :Float, min :Float, max :Float ) {
		if( value < min )
			return false;
		if( value > max )
			return false;
		return true;
	}
	
}