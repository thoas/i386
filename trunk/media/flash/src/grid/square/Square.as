﻿package grid.square 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Square extends Sprite
	{
		public static const SQUARE_WIDTH:int = 50;
		public static const SQUARE_HEIGHT:int = 50;
		// scale : 26px, 78px, 182px, 416px, 800px (max 1024 Square pour écran 840*840px)
		// pos : le premier (0, 0)
		private var _x:int;
		private var _y:int;
		private var _color:int;
		
		public function Square(x:int, y:int, color:int, w:int = SQUARE_WIDTH, h:int = SQUARE_HEIGHT) 
		{
			_x = x;
			_y = y;
			buttonMode = true;
			alpha = 0.8;
			graphics.beginFill(color);
			graphics.drawRect(_x*w, _y*h, w, h);
			graphics.endFill();
			SquareManager.add(this);
			
			addEventListener(MouseEvent.ROLL_OVER, _rollOver);
			addEventListener(MouseEvent.ROLL_OUT, _rollOut);
			trace(this.width + " " + this.height);
		}
		
		public function get X():int { return _x };
		
		public function get Y():int { return _y };
		
		private function _rollOver(e:MouseEvent):void
		{
			alpha = 1;
		}
		
		private function _rollOut(e:MouseEvent):void
		{
			alpha = 0.8;
		}
		
	}
	
}