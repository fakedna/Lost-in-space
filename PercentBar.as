package  {
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class PercentBar extends Sprite {
		
		private var t:Sprite;
		private var tf:TextField;
		private var n:Boolean;

		public function PercentBar(c:uint,sx:int=0,sy:int=0,sw:int=200,sh:int=12,num:Boolean=true) {
			var w:int = sw;
			var h:int = sh;
			this.x = sx;
			this.y = sy;
			n = num;
			this.graphics.lineStyle(1,0xCCCCCC);
			this.graphics.beginFill(0x999999);
			this.graphics.drawRect(0,0,w,h);
			PercentBar.createLightGradient(this,0x0,w,h);
			t = new Sprite;
			t.graphics.beginFill(c);
			t.graphics.drawRect(1,1,w-2,h-2);
			PercentBar.createLightGradient(t,0xFFFFFF,w,h);
			this.addChild(t);
			if (n) {
				tf = new TextField;
				tf.selectable = false;
				tf.multiline = false;
				tf.height = h;
				tf.width = w;
				tf.autoSize = TextFieldAutoSize.CENTER;
				tf.defaultTextFormat = new TextFormat("Arial",10,0xFFFFFF,true);
				tf.y -= 2;
				this.addChild(tf);
			}
		}
		
		public function set percent(p:Number) {
			t.scaleX = p;
		}
		public function get percent():Number {
			return t.scaleX;
		}
		
		public function set number(txt:String) {			
			if (n) {
				tf.text = txt;
			}
		}
		public function get number():String {			
			if (n) {
				return tf.text;
			} else {
				return "";
			}
		}
		
		public static function createLightGradient(i:Sprite,ic:uint,iw:int,ih:int) {				
				var matrix = new Matrix;
				matrix.createGradientBox(iw,ih/2,Math.PI/2,0,0); // boxWidth, boxHeight, boxRotation, tx, ty
				i.graphics.beginGradientFill(GradientType.LINEAR, // type,
					[ic, ic], [.8,0], [0,255], matrix); // colors, alphas, ratios, matrix
				i.graphics.drawRect(0,0,iw,ih);
				i.graphics.endFill();
		}

	}
	
}
