package  {
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ScreenClass extends ScreenBack {
		
		private var spPictures:Array;
		private var spArray:Array;
		private var tpArray:Array;
		private var bc:BackgroundLines;

		public function ScreenClass() {
			var mb1:MenuButton = new MenuButton("Back",0,0,back);
			var mb2:MenuButton = new MenuButton("Go!",0,0,startGame);
			spPictures = [new Bitmap(new sPicture1),new Bitmap(new sPicture2),new Bitmap(new sPicture3)]
			spArray = new Array;
			for (var i:int=0; i<3; i++) {
				var sp:ShipPicture = new ShipPicture(spPictures[i],i*200,40,200,320);
				sp.addEventListener("CircleClick",makeItChoosed);
				spArray.push(sp);
			}
			spArray[1].choose();
			tpArray = new Array;
			var tp1:TextPanel = new TextPanel(5,360,435,50,20,Text.class1);
			var tp2:TextPanel = new TextPanel(5,410,435,140,15,Text.class1desc);
			var tp3:TextPanel = new TextPanel(440,360,150,190,20,"\nХаракте-ристики (TODO)");
			tpArray.push(tp1,tp2,tp3);
			bc = new BackgroundLines(0,0,true,600,600,0xCCCCCC,0x999999,1,2,Math.PI/3);
			super(Text.classTitle,[mb1,mb2],spArray.concat(tpArray),bc);
		}
		
		private function makeItChoosed(event:Event) {
			for (var i:int=0; i<spArray.length; i++) {
				spArray[i].unchoose();
			}
			event.target.choose();
			if (spArray[0].isChoosed) {
				tpArray[0].changeText(Text.class0);
				tpArray[1].changeText(Text.class0desc);
			}
			if (spArray[1].isChoosed) {
				tpArray[0].changeText(Text.class1);
				tpArray[1].changeText(Text.class1desc);
			}
			if (spArray[2].isChoosed) {
				tpArray[0].changeText(Text.class2);
				tpArray[1].changeText(Text.class2desc);
			}
		}
		
		private function back(event:MouseEvent) {
			var p = this.parent;
			//trace(p);
			p.removeChild(this);
			p.addChild(this);
		}
		
		private function startGame(event:MouseEvent) {		
			var p = this.parent;	
			p.removeChild(this);
			Game.player = new Player("balanced");
			var game = new Game(0);
			p.addChild(game);
		}

	}
	
}
