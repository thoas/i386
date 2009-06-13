package cc.milkshape.grid.square 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import cc.milkshape.grid.square.events.SquareEvent;
	
	public class Square extends Sprite
	{
		private var _x:int;
		private var _y:int;
		private var _color:int;
		
		public function Square(x:int, y:int, color:int, size:int) 
		{
			buttonMode = true;
			doubleClickEnabled = true;
			
			_x = x;
			_y = y;
					
			// alpha = 0.8	
			alpha = 0;
			
			graphics.beginFill(color);
			graphics.drawRect(0, 0, size, size);
			graphics.endFill();
			
			addEventListener(FocusEvent.FOCUS_IN, _focusIn);
			addEventListener(FocusEvent.FOCUS_OUT, _focusOut);
			addEventListener(MouseEvent.ROLL_OVER, _rollOver);
			
			SquareManager.add(this);
		}
		
		public function get Y():int
		{
			return _y;
		}

		public function set Y(v:int):void
		{
			_y = v;
		}

		public function get X():int
		{
			return _x;
		}

		public function set X(v:int):void
		{
			_x = v;
		}

		private function _focusIn(e:Event):void
		{
			//alpha = 1;
			dispatchEvent(new SquareEvent(SquareEvent.FOCUS, this));
		}
		
		private function _focusOut(e:FocusEvent):void
		{
			// alpha = 0.8	
			alpha = 0;
		}
		
		private function _rollOver(e:MouseEvent):void
		{
			dispatchEvent(new SquareEvent(SquareEvent.OVER, this));			
		}
	}
	
}