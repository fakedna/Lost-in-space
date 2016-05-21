package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Game extends MovieClip {
		
		public static var objArray:Array;
		public static var player:Player;

		public function Game(level:Number=0) {
			loadBackground(level);
			loadShip();
			loadInterface();
			var sc:Scenario = new Scenario(level,this);
		}
		
		private function loadShip() {
			var img:GameObject = Game.player.ship;
			img.position.x = 300;
			img.position.y = 500;
			this.addChild(img);
		}
		
		private function loadInterface() {
			var w:int = 600;
			var h:int = 40;
			var iface:Sprite = new Sprite;
			iface.graphics.lineStyle(2,0);
			iface.graphics.beginFill(0x333333,.9);
			iface.graphics.drawRect(0,0,w,h);
			PercentBar.createLightGradient(iface,0xFFFFFF,w,h);
			var hpBar:PercentBar = new PercentBar(0x009900,6,7);
			var epBar:PercentBar = new PercentBar(0x000099,6,24);			
			Game.player.ship.addEventListener("HP_CHANGE",onHp);
			Game.player.ship.addEventListener("EP_CHANGE",onEp);
			Game.player.ship.dispatchEvent(new Event("HP_CHANGE"));
			Game.player.ship.dispatchEvent(new Event("EP_CHANGE"));
			function onHp(event:Event) {
				hpBar.percent = Game.player.ship.hp/Game.player.HP;
				hpBar.number = Game.player.ship.hp+"/"+Game.player.HP;
			}
			function onEp(event:Event) {
				epBar.percent = Game.player.ship.ep/Game.player.shield;
				epBar.number = Game.player.ship.ep+"/"+Game.player.shield;
			}
			iface.addChild(hpBar);
			iface.addChild(epBar);
			iface.y += w-h;
			this.addChild(iface);
			
		}
		
		private function loadBackground(l:Number) {
			switch (Math.round(l/10)) {
				case 0: {
					this.addChildAt(new BackgroundStars(0,0,600,600,0x00FFFF,10,6),0);
				} break;
				case 1: {
					this.addChildAt(new BackgroundStars(0,0,600,600,0x990000,10,6),0);
				} break;
			}
		}
		
	}
	
}
