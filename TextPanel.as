package  {
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.filters.GlowFilter;
	import flash.filters.BevelFilter;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	
	public class TextPanel extends Sprite {
		
		private var tf:TextField;
		private var string:String;
		private var w:Number;
		private var h:Number;
		private var count:int;
		private var timer:Timer;
		private var ts:Number;
		
		private const leading:Number = 5;
		private const sizedec:Number = 5;
		private const doublesd:Number = sizedec*2;

		public function TextPanel(tx:Number,ty:Number,tWidth:Number,tHeight:Number,lSize:Number,
								  txt:String,pColor:uint=0x66CCFF,tColor:uint=0x003333) {
			this.x = tx; this.y = ty;
			w = tWidth; h = tHeight;
			string = txt;
			ts = lSize;
			setPanelColor(pColor);
			addTextField(tColor);
			//drawLines(tColor);
			//tf.filters = [new GlowFilter(pColor)];
			this.filters = [new DropShadowFilter(sizedec*2,45,0,1,4,4,1,3)];
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(event:Event) {
			changeText(string);
		}
		
		private function drawLines(c:uint) {
			var lh:Number = tf.getLineMetrics(0).height;
			var max:Number = (h-doublesd)/lh-1;
			this.graphics.lineStyle(1,c);
			for (var i:int=0; i<max; i++) {
				this.graphics.moveTo(doublesd*2,doublesd+(i+1)*lh);
				this.graphics.lineTo(w-doublesd*2,doublesd+(i+1)*lh);
			}
		}
		
		private function addTextField(c:uint) {
			tf = new TextField;
			setupTextField(tf);
			setTextColor(c);
			this.addChild(tf);
		}
		
		private function setupTextField(t:TextField) {
			t.width = w-doublesd*4;
			t.height = h-doublesd*2;
			t.x = doublesd*2;
			t.y = doublesd;
			t.selectable = false;
			t.multiline = true;
			t.wordWrap = true;
			t.autoSize = TextFieldAutoSize.LEFT;
			var dtf:TextFormat = new TextFormat("Segoe UI",ts,0xFFFFFF);
			//dtf.leading = leading;
			t.defaultTextFormat = dtf;
			//Century Gothic, MS Reference Sans Serif, Tahoma, Segoe UI
		}
		
		private function printText():void {
			tf.text = "";
			count = 0;
			var delay = 160/Global.textSpeed;
			timer = new Timer(delay);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, printTextTimer);		
		}
		
		private function printTextTimer(event:TimerEvent) {							
			tf.appendText(string.charAt(count));
			count++;
			if (count == string.length) {
				timer.stop();
				count = 0;
			}   
		}
		
		public function changeText(s:String) {
			if (timer) if (timer.running) timer.stop();
			string = s;
			printText();
		}
		
		public function setPanelColor(c:uint) {
			this.graphics.clear();
			this.graphics.beginFill(c,.6);
			this.graphics.drawRect(sizedec,sizedec,w-doublesd,h-doublesd);
			this.graphics.endFill();
		}
		
		public function setTextColor(c:uint) {
			tf.textColor = c;
		}
		

	}
	
}
