package  {
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import grape.*;
	import grape.path.*;
	
	public class Scenario {
		
		private var base:Game;

		public function Scenario(lvl:Number,target:Game) {
			Game.objArray = new Array;
			base = target;
			switch (lvl) {
				case 0: {
					lvl0();
				} break;
				case 1: {
					lvl1();					
				} break;
				case 2: {
					lvl2();					
				} break;
				case 3: {
					lvl3();					
				} break;
			}
		}
		
		private function createEnemies(enemyName:String,count:int,delay:int,flyingTime:int,
									trajectory:String="",loop:Boolean=false,reverse:Boolean=false,
									xCount:int=1,dShoot:int=1) {
			var timer:Timer = new Timer(delay,count*xCount);
			timer.addEventListener(TimerEvent.TIMER,addEnemy);
			timer.start();			
			function addEnemy(event:TimerEvent) {
				var enemy:Enemy = new Enemy(enemyName);
				var anim:Animation = createAnimation(enemy,trajectory,flyingTime,loop,reverse);
				base.addChild(enemy);
				Game.objArray.push(enemy);
				var rand:int = (1500+Math.random()*1000)/dShoot;
				enemy.preformMainAttack(rand);
			}
		}
		
		private function createAnimation(e:Enemy,trj:String,ft:int,lp:Boolean,rv:Boolean):Animation {
			var path:Path2D = createTrajectory(trj);
			return Grape.getInstance().create2DAnimation(e,path,ft,-1,null,lp,rv);
		}
		
		private function createTrajectory(trj:String):Path2D {
			var path:Path2D;
			switch(trj) {
				case "lips": {
					var p:Vector.<Number> = new <Number>[-200,50,400,150,500,200,300,
														 300,100,200,200,150,800,50];					
					path = new CosineSplinePath2D(p);
					//path.render(base.graphics);
				} break;
				case "": {
					
				} break;
			}
			return path;
		}	
		
		private function playBGM(w:int) {
			
		}
		
		private function lvl0() {
			playBGM(0);
			createEnemies("Bee",10,800,10000,"lips");
			createEnemies("Bee",10,800,10000,"lips",false,true);
		}
		
		private function lvl1() {
			
		}
		
		private function lvl2() {
			
		}
		
		private function lvl3() {
			
		}

	}
	
}
