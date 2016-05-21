package  {
	import flash.display.Sprite;
	
	public class Player {
		
		private var plType:String;
		private var plShip:Ship;
		private var level:int;
		
		private var expirience:int;
		private var atkstr:int; //calculate damage
		private var atkspd:int; //calculate shoot's speed
		private var shldrr:int; //calculate shield recovery rate
		private var spclrr:int; //calculate special recovery rate
		private var hitPoints:int;
		
		private var shieldNow:int;

		public function Player(type:String) {
			plType = type;
			plShip = new Ship(type);
			level = 0;
			expirience = 0;
			switch (type) {
				case "light": {
					atkstr = 1;
					atkspd = 6;
					shldrr = 5;
					spclrr = 3;
					hitPoints = 10;
				} break;
				case "balanced": {
					atkstr = 4;
					atkspd = 4;
					shldrr = 4;
					spclrr = 3;
					hitPoints = 20;
				} break;
				case "heavy": {
					atkstr = 6;
					atkspd = 2;
					shldrr = 3;
					spclrr = 4;
					hitPoints = 30;
				} break;
			}
			renew();
		}
		
		public function renew() {
			shieldNow = 100;
			plShip.hp = hitPoints;
			plShip.ep = shieldNow;
		}
		
		public function calculate() {
			
		}
	////////////////////////////////////////////////////////////////////
		public function get type():String {
			return plType;
		}
		public function get ship():Ship {
			return plShip;
		}			
		public function get lvl():int {
			return level;
		}
	////////////////////////////////////////////////////////////////////
		public function get atk():int {
			return atkstr;
		}
		public function set atk(a:int) {
			atkstr = a;
		}
		public function get spd():int {
			return atkspd;
		}
		public function set spd(s:int) {
			atkspd = s;
		}
		public function get srr():int {
			return shldrr;
		}
		public function set srr(sr:int) {
			shldrr = sr;
		}
		public function get spc():int {
			return spclrr;
		}
		public function set spc(sp:int) {
			spclrr = sp;
		}
	////////////////////////////////////////////////////////////////////
		public function get HP():int {
			return hitPoints;
		}
		public function set HP(h:int) {
			hitPoints = h;
		}
		public function get shield():int {
			return shieldNow;
		}
		public function set shield(sh:int) {
			shieldNow = sh;
		}
		
	}
	
}
