package  {
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.filters.GlowFilter;
	
	public class BackgroundLines extends Sprite {
		
		private var bd:BitmapData;
		private var sd:Sprite;
		private var th:Number;
		private var matrix:Matrix;
		private var w:Number;
		private var h:Number;
		private var r:Boolean;

		public function BackgroundLines(sx:Number,sy:Number,rect:Boolean,sWidth:Number,sHeight:Number,
						color1:uint,color2:uint=0xFFFFFF,alpha:Number=1,thickness:Number=5,angle:Number=Math.PI/4) {
			this.x = sx; this.y = sy;
			this.alpha = alpha;
			w = sWidth; h = sHeight;
			th = thickness;	r = rect;
			matrix = new Matrix;
			matrix.rotate(angle);
			bd = new BitmapData(th*2,th,true);
			sd = new Sprite;
			setColor(color1,color2);
			this.filters = [Global.glowShadow]
			this.cacheAsBitmap = true;
		}
		
		public function setColor(color1:uint,color2:uint=0xFFFFFF) {
			sd.graphics.clear();
			sd.graphics.beginFill(color1);
			sd.graphics.drawRect(0,0,th,th);
			sd.graphics.beginFill(color2);
			sd.graphics.drawRect(th,0,th,th);
			sd.graphics.endFill();
			bd.draw(sd);
			this.graphics.clear();
			this.graphics.beginBitmapFill(bd,matrix,true,true);
			if (r) this.graphics.drawRect(0,0,w,h);
			else this.graphics.drawEllipse(0,0,w,h);
			this.graphics.endFill();
		}
		
		

	}
	
}
