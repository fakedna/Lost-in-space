package  {
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.events.Event;
	
	public class Bullet extends GameObject {
		
		private var dmg:int;
		private var destructable:Boolean;
		
		public function Bullet(type:String,posX:Number=0,posY:Number=0,reverse:Boolean=false) {
			super(true,posX,posY);
			var r:int = 1;
			if (reverse) {
				r = -1;
				this.addEventListener(Event.ENTER_FRAME,hitTestReverse);
			} else {				
				this.addEventListener(Event.ENTER_FRAME,hitTest);
			}
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			switch(type) {
				case "doubleShot": {
					for (var j:int=0;j<=1;j++) {
						var b1:Sprite = ball(0xCCFF00,0x11FFFF,3);
						b1.x = 10-20*j;
						b1.y = 0;
						this.addChild(b1);
					}
					this.speed.x = 0;
					this.speed.y = r*10;
					this.dmg = 2;
					this.hp = 1;
					this.ep = 0;
				} break;
			}
		}
		
		private function onRemoved(event:Event) {		
			this.removeEventListener(Event.ENTER_FRAME,hitTest);
			this.removeEventListener(Event.ENTER_FRAME,hitTestReverse);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		private function hitTest(event:Event) {		
			if (checkCollision(Game.player.ship)) {
				Game.player.ship.dispatchEvent(new Event("HP_CHANGE"));
			}
		}
		
		private function hitTestReverse(event:Event) {	
			for(var p:int=0;p<Game.objArray.length;p++) {
				checkCollision(Game.objArray[p]);
			}			
		}
		
		private function checkCollision(target:GameObject):Boolean {				
			var rect = CollisionDetection.checkForCollision(this,target);
			if (rect) {
				trace("boom",target);
				target.hp -= this.dmg;
				this.removeEventListener(Event.ENTER_FRAME,hitTest);
				parent.removeChild(this);
				return true;
			} else {
				return false;
			}
		}
		
		private function ball(c:uint,gc:uint,r:int):Sprite {
			var b:Sprite = new Sprite;
			b.graphics.beginFill(c);
			b.graphics.drawCircle(-r/2,-r/2,r);
			b.graphics.endFill();
			var glow:GlowFilter = new GlowFilter(gc);
			b.filters = [glow];
			return b;
		}
		
		public function get damage():int {
			return dmg;
		}
		
	}
	
}
