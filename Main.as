package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.display.StageScaleMode;
	import flash.display.Bitmap;	
	
	public class Main extends MovieClip {
		
		
		public function Main() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var mb1:MenuButton;
			var mb2:MenuButton;
			mb1 = new MenuButton("Start",100,100,startGame);
			mb2 = new MenuButton("Options",100,150,options);
			addChild(new Bitmap(new back1));
			addChild(mb1);
			addChild(mb2);
			//addSystemInfo();
			setGlobalOptions();
		}
		
		private function addSystemInfo() {
			var txt:TextField = new TextField;
			txt.selectable = false;
			txt.textColor = 0xFFFFFF;
			stage.addEventListener(Event.ENTER_FRAME, updateInfo)
			function updateInfo():void {
				txt.text = "Memory: "+System.totalMemory/1024+"Kb\nFPS: "+stage.frameRate;
			}
			stage.addChild(txt);
		}
		
		private function startGame(event:MouseEvent) {
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
			this.addChild(new ScreenClass());
		}
		
		private function setGlobalOptions() {
			Global.setValues();
		}
		
		private function options(event:MouseEvent) {
			
		}
	}
	
}
