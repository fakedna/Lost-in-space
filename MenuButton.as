package  {
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.filters.DropShadowFilter;
	import flash.filters.BlurFilter;
	
	public class MenuButton extends SimpleButton {
		
		private const w:Number = 120;
		private const h:Number = 30;
		private const cb:uint = 0x3D3D64;
		private const ct:uint = 0x999999;

		public function MenuButton(name:String,x:Number,y:Number,funct:Function) {
			this.x = x;
			this.y = y;
			this.addEventListener(MouseEvent.CLICK,funct);
			var viewUp:Sprite = new Sprite;			
			drawGraphics(viewUp);
			viewUp.addChild(createText(name));
			viewUp.filters = [new DropShadowFilter];
			var viewOver:Sprite = new Sprite;
			viewOver.graphics.lineStyle(2,0xFFFFFF);
			drawGraphics(viewOver);
			viewOver.addChild(createText(name));
			var viewDown:Sprite = new Sprite;	
			drawGraphics(viewDown);
			viewDown.addChild(createText(name));
			viewDown.filters = [new BlurFilter];
			this.upState = viewUp;
			this.overState = viewOver;
			this.downState = viewDown;
			this.hitTestState = viewUp;
		}
		
		private function createText(t:String):TextField {
			var txtFormat:TextFormat = new TextFormat;
			txtFormat.font = "Segoe Print";
			txtFormat.size = 18;
			txtFormat.color = ct;
			var txt:TextField = new TextField;
			txt.width = w;
			txt.height = h;
			txt.autoSize = TextFieldAutoSize.CENTER;
			txt.defaultTextFormat = txtFormat;	
			txt.text = t;
			txt.cacheAsBitmap = true;
			txt.selectable = false;
			return txt;
		}
		
		private function drawGraphics(s:Sprite) {
			s.graphics.beginFill(cb);
			s.graphics.drawRoundRect(0,0,w,h,10);
			var matrix = new Matrix;
			matrix.createGradientBox(w,h/2,Math.PI/2,0,0); // boxWidth, boxHeight, boxRotation, tx, ty
			s.graphics.beginGradientFill(GradientType.LINEAR, // type,
				[0xFFFFFF, 0xFFFFFF], [.8,0], [0,255], matrix); // colors, alphas, ratios, matrix
			s.graphics.drawRoundRect(0,0,w,h,10);
			s.graphics.endFill();			
		}

	}
	
}
