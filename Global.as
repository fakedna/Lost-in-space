package  {
	
	import flash.filters.GlowFilter;
	
	public class Global {
		
		public static var quality:int;
		public static var starSpeed:int;
		public static var starColor:uint;
		public static var textSpeed:int;
		
		public static const glowShadow:GlowFilter = new GlowFilter(0x0,1,16,16,2,1,true);
		
		public static function setValues(values:Array=null) {
			if (values == null) {
				values = new Array;
				values = [3,10,0xFFFFFF,5];
			}
			quality = values[0];
			starSpeed = values[1];
			starColor = values[2];
			textSpeed = values[3];
		}
		
		public static function randBool():Boolean {
			if (Math.random() < 0.5) {
				return false;
			} else {
				return true;
			}
		}

	}
	
}
