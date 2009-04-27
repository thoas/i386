package grid.square 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	public class Square extends Sprite
	{
		public static var count:int = 0;
		public static const SQUARE_WIDTH:int = 800;
		public static const SQUARE_HEIGHT:int = 800;
		// thumb scale 25;50;100;200;400;800
		// first point (0, 0)
		private var _x:int;
		private var _y:int;
		private var _color:int;
		
		public function Square(x:int, y:int, color:int, w:int = SQUARE_WIDTH, h:int = SQUARE_HEIGHT) 
		{
			tabIndex = count++;// Index de tabulation
			
			_x = x;
			_y = y;
			
			buttonMode = true;
			doubleClickEnabled = true;
			alpha = 0.8;
			graphics.beginFill(color);
			graphics.drawRect(_x*w, _y*h, w, h);
			graphics.endFill();
			SquareManager.add(this);
			
			// Evénements propres à une Square
			addEventListener(FocusEvent.FOCUS_IN, _focusIn);
			addEventListener(FocusEvent.FOCUS_OUT, _focusOut);
			addEventListener(MouseEvent.ROLL_OVER, _rollOver);
			addEventListener(MouseEvent.ROLL_OUT, _rollOut);
		}
		
		public function get X():int { return _x };
		
		public function get Y():int { return _y };
		
		private function _focusIn(e:Event):void
		{
			_rollOver(null);
			dispatchEvent(new SquareEvent(SquareEvent.SQUARE_MOVE, this));
		}
		
		private function _focusOut(e:Event):void
		{
			_rollOut(null);
		}
		
		private function _rollOver(e:Event):void
		{
			dispatchEvent(new SquareEvent(SquareEvent.SQUARE_FOCUS, this));
			alpha = 1;
			//trace(_x + ";" + _y);
		}
		
		private function _rollOut(e:Event):void
		{
			alpha = 0.8;
		}
		
	}
	
}