package  {
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	
	public class Enemy extends GameObject {
		
		private var dataArray:Array;
		// 0 - name
		// 1 - image
		// 2 - exp
		// 3 - hp
		// 4 - ep
		private var mainAttack:String;
		private var secondAttack:String;
		private var timerM:Timer;
		private var timerS:Timer;
		
		public function Enemy(enemyName:String) {
			super(false);
			switch (enemyName) {
				case "Bee": {
					dataArray = ["Bee",new Bee,5,2,0];
					mainAttack = "doubleShot";
					secondAttack = "";
				} break;
			}
			this.hp = dataArray[3];
			this.addChild(dataArray[1]);
			this.addEventListener(Event.ENTER_FRAME,hitTest);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		private function onRemoved(event:Event) {
			if (timerM) {
				timerM.stop();
				timerM.removeEventListener(TimerEvent.TIMER,shoot1);
			}			
			if (timerS) {
				timerS.stop();
				timerS.removeEventListener(TimerEvent.TIMER,shoot2);
			}
			this.removeEventListener(Event.ENTER_FRAME,hitTest);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		private function hitTest(event:Event) {
			var rect = CollisionDetection.checkForCollision(this,Game.player.ship);
			if (rect) {
				Game.player.ship.hp -= dataArray[3];
				Game.player.ship.dispatchEvent(new Event("HP_CHANGE"));
				this.hp -= dataArray[3];
			}
		}
		
		private function shoot1(event:TimerEvent) {	
			dataArray[1].gotoAndPlay("Shoot1");
			var bullet:Bullet = new Bullet(mainAttack,this.x,this.y);
			this.parent.addChildAt(bullet,0);
		}
		
		private function shoot2(event:TimerEvent) {
			var bullet:Bullet = new Bullet(secondAttack,this.x,this.y);
			if (this.ep >= bullet.ep) {
				dataArray[1].gotoAndPlay("Shoot2");
				this.parent.addChildAt(bullet,0);
			} else { bullet = null }
		}
		
		public function preformMainAttack(delay:int) {
			timerM = new Timer(delay);
			timerM.addEventListener(TimerEvent.TIMER,shoot1);
			timerM.start();
		}
		
		public function preformSecondAttack(delay:int) {
			timerS = new Timer(delay);
			timerS.addEventListener(TimerEvent.TIMER,shoot2);
			timerS.start();
		}
		
		public function get enemyName():String {
			return dataArray[0];
		}
		public function get image():MovieClip {
			return dataArray[1];
		}
		public function get expirience():int {
			return dataArray[2];
		}		
		public function get hitPoints():int {
			return dataArray[3];
		}		
		public function get energyPoints():int {
			return dataArray[4];
		}

	}
	
}
