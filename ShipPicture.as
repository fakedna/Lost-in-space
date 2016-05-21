package  {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.filters.GlowFilter;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class ShipPicture extends BackgroundCorners {
		
		private var circle:Sprite;
		private var back:BackgroundLines;
		private var choosed:Boolean;
		
		private const cMatrix:Matrix = new Matrix;
		private const cRadius:Number = 85;
		private const rh:Number = cRadius/2;
		private const cThick:Number = 15;
		private const exval:Number = .1;
		private const exmax:Number = 1.5;
		private const defScaleMult:Number = 1.5;
		private const extime:int = 30;
		private const tColor:uint = 0x3366CC;
		private const fColor:uint = 0xCC0000;

		public function ShipPicture(img:DisplayObject,x:Number,y:Number,w:Number,h:Number,cSize:Number=40) {
			super(x,y,w,h);
			this.x = x;
			this.y = y;
			addCircle(this,img)
			unchoose();
		}
		
		public function choose() {
			choosed = true;
			redrawCircle(tColor);
			circle.filters = [new GlowFilter(0xFFFFFF,1,10,10)];
			setGlowColor(tColor);
		}
		
		public function unchoose() {
			choosed = false;
			redrawCircle(fColor);
			circle.filters = [new GlowFilter(0x0,1,10,10)];
			setGlowColor(fColor);
		}
		
		public function get isChoosed():Boolean {
			return choosed;
		}
		
		private function addCircle(s:Sprite,img:DisplayObject) {
			var objCircle:Sprite = drawObjCircle(img);
			objCircle.addEventListener(MouseEvent.CLICK,onClick);
			function onClick(event:MouseEvent) {
				s.dispatchEvent(new Event("CircleClick"));
			}
			s.addChild(objCircle);
		}
		
		private function redrawCircle(c:uint) {
			circle.graphics.clear();
			circle.graphics.lineStyle(cThick);
			circle.graphics.lineGradientStyle(GradientType.RADIAL, // type,
					[0xFFFFFF,c], [1,1], [128,255], cMatrix); // colors, alphas, ratios, matrix
			circle.graphics.drawCircle(rh,rh,cRadius);
			circle.graphics.endFill();
			back.setColor(c);
		}
		
		private function drawObjCircle(image:DisplayObject):Sprite {
			var s:Sprite = new Sprite;
			back = new BackgroundLines(-rh,-rh,false,cRadius*2,cRadius*2,fColor,0xFFFFFF,.5,1);
			cMatrix.createGradientBox((cRadius+cThick)*2,(cRadius+cThick)*2,0,-rh-cThick,-rh-cThick);
			circle = new Sprite;
			// Image
			var imgSp:Sprite = new Sprite;
			imgSp.addChild(image);
			var defScale:Number = cRadius/imgSp.width*defScaleMult;
			imgSp.scaleX = defScale;
			imgSp.scaleY = defScale;
			imgSp.x = rh-imgSp.width/2;
			imgSp.y = rh-imgSp.height/2;
			imgSp.addEventListener(MouseEvent.MOUSE_OVER,scaleUpT);
			imgSp.addEventListener(MouseEvent.MOUSE_OUT,scaleDownT);
			var timerUp:Timer = new Timer(extime);
			var timerDown:Timer = new Timer(extime);
			timerUp.addEventListener(TimerEvent.TIMER,scaleUp);
			timerDown.addEventListener(TimerEvent.TIMER,scaleDown);			
			function scaleUpT(event:MouseEvent) {
				timerDown.stop();
				timerUp.start();
			}		
			function scaleDownT(event:MouseEvent) {
				timerUp.stop();
				timerDown.start();
			}
			function scaleUp(event:TimerEvent) {
				if (imgSp.scaleX <= defScale*exmax) {
					imgSp.scaleX += exval;
					imgSp.scaleY += exval;
				} else {
					imgSp.scaleX = defScale*exmax;
					imgSp.scaleY = defScale*exmax;
					event.target.stop();
				}
				imgSp.x = rh-imgSp.width/2;
				imgSp.y = rh-imgSp.height/2;
			}
			function scaleDown(event:TimerEvent) {				
				if (imgSp.scaleX >= defScale) {
					imgSp.scaleX -= exval;
					imgSp.scaleY -= exval;
				} else {
					imgSp.scaleX = defScale;
					imgSp.scaleY = defScale;
					event.target.stop();
				}
				imgSp.x = rh-imgSp.width/2;
				imgSp.y = rh-imgSp.height/2;
			}
			// Add&Arrange
			s.addChild(back);
			s.addChild(circle);
			s.addChild(imgSp);
			s.x = (this.width-cRadius)/2;
			s.y = (this.height-cRadius)/2;
			return s;
		}
		
	}
	
}
