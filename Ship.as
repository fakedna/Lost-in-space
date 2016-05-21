package  {
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Ship extends GameObject {
		
		private const sd:Number = 1;
		private const sp:Number = 3;
		private const sm:Number = 12;
		private const timer:Timer = new Timer(300);
		private var pkeys:keys;

		public function Ship(type:String) {
			var mc:MovieClip;
			switch(type) {				
				case "light": {
				} break;
				case "balanced": {
					mc = new ShipModel1;
				} break;
				case "heavy": {
				} break;
			}
			this.addChild(mc);
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			this.addEventListener(Event.ENTER_FRAME, renew);
		}
		
		private function onAdded(event:Event) {
			pkeys = new keys(this);
			stage.focus = this.parent;
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
		}
		
		private function onRemoved(event:Event) {			
			this.removeEventListener(Event.ENTER_FRAME, renew);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		private function renew(event:Event) {
//////////////scene bounds
			if (this.position.x <= 0) {
				this.position.x = 0;
				this.speed.x = 0;
			}
			if (this.position.x >= stage.stageWidth) {
				this.position.x = stage.stageWidth;
				this.speed.x = 0;
			}
			if (this.position.y <= 0) {
				this.position.y = 0;
				this.speed.y = 0;
			}
			if (this.position.y >= stage.stageWidth-100) {
				this.position.y = stage.stageWidth-100;
				this.speed.y = 0;
			}
//////////////controls
			if (pkeys.is_left) {
				this.speed.x -= sp;
			}
			if (pkeys.is_right) {
				this.speed.x += sp;				
			}
			if (pkeys.is_up) {
				this.speed.y -= sp;
			}
			if (pkeys.is_down) {
				this.speed.y += sp;
			}
			if (pkeys.is_ctrl) {
				timer.start();
			}
//////////////slow down
			if (this.speed.x > 0) {
				this.speed.x -= sd;
			}
			if (this.speed.x < 0) {
				this.speed.x += sd;
			}
			if (this.speed.y > 0) {
				this.speed.y -= sd;
			}
			if (this.speed.y < 0) {
				this.speed.y += sd;
			}	
//////////////max speed limit
			if (this.speed.x > sm) {
				this.speed.x = sm;
			}
			if (this.speed.y > sm) {
				this.speed.y = sm;
			}
			if (this.speed.x < -sm) {
				this.speed.x = -sm;
			}
			if (this.speed.y < -sm) {
				this.speed.y = -sm;
			}
		}
		
		private function onTimer(event:TimerEvent) {
			shoot();
		}
		
		private function shoot() {			
			this.gotoAndPlay("Shoot1");
			var bullet:Bullet = new Bullet("doubleShot",this.x,this.y,true);
			this.parent.addChildAt(bullet,0);
			timer.stop();
		}

	}
	
}
