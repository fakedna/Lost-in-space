package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	
	public class BackgroundStars extends Sprite {
		
		private var targetW:Number;
		private var targetH:Number;
		private var bgLength:Number;
		private var moveZero:Number;
		private var matrix:Matrix;
				
		public function BackgroundStars(tx:Number,ty:Number,w:Number,h:Number,color:uint,starNum:Number,
										leng:Number=1,moving:Boolean=true) {
			targetW = w;
			targetH = h;
			bgLength = targetH*leng;
			moveZero = ty;
			matrix = new Matrix;
			this.graphics.beginFill(color,.1);
			this.graphics.drawRect(0,0,targetW,bgLength*2);
			this.graphics.endFill();
			var starRandNum:Number = (starNum*1.5-Math.random()*(starNum))*leng;
			drawStars(starRandNum);
			if (moving) {
				this.addEventListener(Event.ENTER_FRAME, moveBg);
			}
			this.x += tx;
			this.y += ty-targetW;
			this.cacheAsBitmap = true;
		}
		
		private function drawStars(num:Number) {
			for (var i:int=0; i<num; i++) {
				var sx:Number = Math.random()*targetW;
				var sy:Number = Math.random()*bgLength;
				var rad:Number = 1+Math.random()*2;
				drawStar(sx,sy,rad);
				drawStar(sx,sy+bgLength,rad);
				this.graphics.endFill();
			}
		}
		
		private function drawStar(stx:Number,sty:Number,radius:Number) {
			matrix.createGradientBox(radius*2,radius*2,0,stx-radius,sty-radius);
			// boxWidth, boxHeight, boxRotation, tx, ty
			this.graphics.beginGradientFill(GradientType.RADIAL, // type,
				[Global.starColor, Global.starColor], [1,0], [0,255], matrix); // colors, alphas, ratios, matrix
			this.graphics.drawCircle(stx,sty,radius);
		}		
		
		private function moveBg(event:Event) {				
			this.y += Global.starSpeed;
			if (this.y >= moveZero) {
				this.y -= bgLength;
			}
		}
	}
	
}
