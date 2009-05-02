package grid.square 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	public class Square extends Sprite
	{
		public static const SQUARE_WIDTH:int = 800;
		public static const SQUARE_HEIGHT:int = 800;
		protected var _x:int;
		protected var _y:int;
		private var _color:int;
		
		public function Square(x:int, y:int, color:int, w:int = SQUARE_WIDTH, h:int = SQUARE_HEIGHT) 
		{
			doubleClickEnabled = true;
			buttonMode = true;
			
			_x = x;
			_y = y;
						
			alpha = 0.5;
			
			graphics.beginFill(color);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
			
			addEventListener(FocusEvent.FOCUS_IN, _focusIn);
			addEventListener(FocusEvent.FOCUS_OUT, _focusOut);
			addEventListener(MouseEvent.ROLL_OVER, _rollOver);
			
			SquareManager.add(this);
		}
		
		public function get X():int { return _x };
		
		public function get Y():int { return _y };
		
		private function _focusIn(e:Event):void
		{
			alpha = 1;
			dispatchEvent(new SquareEvent(SquareEvent.SQUARE_FOCUS, this));
			//trace("tabIndex : "+ tabIndex + " pos : "+_x + ";" + _y);
		}
		
		private function _focusOut(e:Event):void
		{
			alpha = 0.5;
		}
		
		private function _rollOver(e:Event):void
		{
			dispatchEvent(new SquareEvent(SquareEvent.SQUARE_OVER, this));			
		}
		
	}
	
}