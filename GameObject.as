package  {
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class GameObject extends MovieClip {
		
		private var pos:Vector3D;
		private var sp:Vector3D;
		private var rtt:Boolean;
		private var mov:Boolean;
		
		private var engp:int;
		private var hitp:int;

		public function GameObject(moving:Boolean=true,x:Number=0,y:Number=0) {
			// set initial position and speed
			pos = new Vector3D(x,y);
			sp = new Vector3D(0,0);
			rtt = false;
			mov = moving;
			this.x = pos.x;
			this.y = pos.y;
			this.addEventListener(Event.ENTER_FRAME, moveObj);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			this.cacheAsBitmap = true;
		}
		
		private function onRemove(event:Event) {
			this.removeEventListener(Event.ENTER_FRAME,moveObj);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemove);
		}
		
		private function moveObj(event:Event):void {
			if (mov) {
				pos = pos.add(sp);
				event.target.x = pos.x;
				event.target.y = pos.y;
			}
			if (rotate) {
				
			}
			if ((this.x < -250)||(this.x > 850)||
				(this.y < -250)||(this.y > 850)) {
				this.parent.removeChild(this);
			}
			if (this.hp <= 0) {				
				this.parent.removeChild(this);
			}
		}
		
		
		public function get position():Vector3D {
			return pos;
		}
		public function set position(p:Vector3D) {
			pos = p;
		}
		
		public function get speed():Vector3D {
			return sp;
		}
		public function set speed(s:Vector3D) {
			sp = s;
		}
		
		public function get rotate():Boolean {
			return rtt;
		}
		public function set rotate(r:Boolean) {
			rtt = r;
		}
		
		public function get hp():int {
			return hitp;
		}
		public function set hp(h:int) {
			hitp = h;
		}
		public function get ep():int {
			return engp;
		}
		public function set ep(e:int) {
			engp = e;
		}


	}
	
}
