package  {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.filters.GlowFilter;
	
	public class ScreenBack extends Sprite {
		
		private var bm:BackgroundCorners;
		private var tl:BackgroundCorners;
		private var tf:TextField;
		private var bp:DisplayObject;
		private var randc:uint;

		public function ScreenBack(sTitle:String,bottomMenuButtons:Array,
								   otherObjects:Array,backPicture:DisplayObject=null) {
			randc = Math.random()*0xFFFFFF;
			addBackground(backPicture);
			addTitle(sTitle);
			addBottomMenu(bottomMenuButtons);
			addObjects(otherObjects);
			this.addEventListener(Event.ADDED_TO_STAGE,redrawBm);
		}
		
		private function redrawBm(event:Event) {
			randc = Math.random()*0xFFFFFF;
			bm.drawNewCorners();
			bm.setGlowColor(randc);
			tl.setGlowColor(randc);
			tf.filters = [new GlowFilter(randc)];
		}
		
		private function addBackground(b:DisplayObject) {
			if (b) {
				bp = b;
			} else {
				bp = new Bitmap(new BitmapData(600,600,true,randc));
			}
			//bp.filters = [new BlurFilter];
			this.addChild(bp);
		}
		
		private function addTitle(s:String) {
			tl = new BackgroundCorners(0,0,600,40,false,randc);
			tl.drawLines([0,0],[8,32],[600,600],[8,32]);
			tf = new TextField;
			setupTextField(tf);
			tf.text = s;
			tf.filters = [new GlowFilter(randc)];
			tl.addChild(tf);
			this.addChild(tl);
		}
		
		private function setupTextField(t:TextField) {
			t.width = 600;
			t.height = 24;
			t.y = 10;
			t.selectable = false;
			t.multiline = false;
			t.embedFonts = true;
			t.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			t.sharpness = -400;
			t.autoSize = TextFieldAutoSize.CENTER;
			t.defaultTextFormat = new TextFormat("Century Gothic",16,0xFFFFFF);
			//Century Gothic, MS Reference Sans Serif, Tahoma, Segoe UI
		}
		
		private function addBottomMenu(buttons:Array) {
			bm = new BackgroundCorners(0,560,600,80,true,randc);
			if (buttons) {
				var num:int = buttons.length;
				var wid:Number = buttons[num-1].width;
				var max:Number = 600-wid*2;
				for (var i:int=0; i<num; i++) {
					buttons[i].y = 5;
					buttons[i].x = wid/2+i*(max/(num-1));
					bm.addChild(buttons[i]);
				}
			}
			this.addChild(bm);
		}
		
		private function addObjects(objects:Array) {
			if (objects) {
				var num:int = objects.length;
				for (var i:int=0; i<num; i++) {
					this.addChild(objects[i]);
				}
			}
		}

	}
	
}
