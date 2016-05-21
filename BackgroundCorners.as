package  {
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.filters.GlowFilter;
	
	public class BackgroundCorners extends Sprite {
		
		private var lines:Sprite;
		private var w:Number;
		private var h:Number;
		private var s:Number;

		public function BackgroundCorners(sx:Number,sy:Number,sWidth:Number,sHeight:Number,cDraw:Boolean=true,
										  cGlow:uint=0xFFFFFF,cColor:uint=0xFFFFFF,cSize:Number=40) {
			this.x = sx; this.y = sy;
			w = sWidth; h = sHeight; s = cSize;
			drawBack();
			lines = new Sprite;
			setGlowColor(cGlow);
			this.addChild(lines);
			if (cDraw) {
				drawNewCorners(cColor);
			}
			this.cacheAsBitmap = true;
		}
		
		private function drawBack() {			
			var matrix = new Matrix;
			matrix.createGradientBox(w,h,Math.PI/3,0,0);
			this.graphics.beginGradientFill(GradientType.LINEAR,
					[0xCCCCCC,0xEEEEEE,0x666666], [1,1,1], [0,64,255], matrix);
			this.graphics.drawRoundRect(0,0,w,h,16);
			this.graphics.endFill();
			this.filters = [Global.glowShadow];
		}
		
		public function drawNewCorners(c:uint=0xFFFFFF) {
			lines.graphics.clear();
			lines.graphics.lineStyle(1,c);
			var num:int = (w*h)/(s*s);
			for (var i:int=0; i<num; i++) {
				var randx:Number = 1+Math.round(Math.random()*(w/s-2));
				var randy:Number = 1+Math.round(Math.random()*(h/s-2));
				var rand1:Boolean = Global.randBool(); 
				var rand2:Boolean = Global.randBool();
				drawCorner(lines,s,randx*s,randy*s,rand1,rand2);
			}
		}
		
		public function drawLines(beginX:Array,beginY:Array,endX:Array,endY:Array,c:uint=0xFFFFFF) {
			lines.graphics.clear();
			lines.graphics.lineStyle(1,c);
			for(var i:int=0; i<beginX.length; i++) {
				lines.graphics.moveTo(beginX[i],beginY[i]);
				lines.graphics.lineTo(endX[i],endY[i]);
			}
		}
		
		public function setGlowColor(c:uint) {
			lines.filters = [new GlowFilter(c)];
		}
		
		private function drawCorner(s:Sprite,size:Number,px:Number,py:Number,right:Boolean,down:Boolean) {
			var com:Vector.<int> = new Vector.<int>(3,true);
			com[0] = 1; com[1] = 2; com[2] = 2;
			var dat:Vector.<Number> = new Vector.<Number>(6,true);
			dat[0] = px; dat[1] = py;
			dat[2] = px; dat[3] = py;
			dat[4] = px; dat[5] = py;
			var cx:Number = px;
			var cy:Number = py;			
			var pntcrddec:Number = size/5;
			if (right) {
				dat[0] += size;
				cx += pntcrddec;
			} else {
				dat[0] -= size;
				cx -= pntcrddec;
			}
			if (down) {
				dat[5] += size;
				cy += pntcrddec;
			} else {
				dat[5] -= size;
				cy -= pntcrddec;
			}
			s.graphics.drawPath(com,dat);
			s.graphics.drawCircle(cx,cy,2);
		}

	}
	
}
