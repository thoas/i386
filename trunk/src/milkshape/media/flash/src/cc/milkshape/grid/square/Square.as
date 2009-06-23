package cc.milkshape.grid.square 
{
	import cc.milkshape.grid.square.events.SquareEvent;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;

	public class Square extends Sprite
	{
		private var _x:int;
		private var _y:int;
		private var _color:int;
		protected var _bg:Shape;
		private var _size:int;
		
		public function Square(x:int, y:int, color:int, size:int) 
		{
			buttonMode = true;
			doubleClickEnabled = true;
			
			_color = color;
			_x = x;
			_y = y;
			_size = size;
			
			_bg = new Shape();
			_bg.graphics.beginFill(_color);
			_bg.graphics.drawRect(0, 0, _size, _size);
			_bg.graphics.endFill();
			addChild(_bg);
			
			addEventListener(FocusEvent.FOCUS_IN, _focusIn);
			addEventListener(FocusEvent.FOCUS_OUT, _focusOut);
			addEventListener(MouseEvent.ROLL_OVER, _rollOver);
			
			SquareManager.add(this);
		}
		
		public function get color():int
		{
			return _color;
		}

		public function set color(v:int):void
		{
			_color = v;
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

		protected function _focusIn(e:Event):void
		{
			dispatchEvent(new SquareEvent(SquareEvent.FOCUS, this));
		}
		
		protected function _focusOut(e:FocusEvent):void
		{
			dispatchEvent(new SquareEvent(SquareEvent.FOCUS_OUT, this));
		}
		
		private function _rollOver(e:MouseEvent):void
		{
			dispatchEvent(new SquareEvent(SquareEvent.OVER, this));			
		}
		
		override public function toString():String
		{
			return '(' + X + ', ' + Y + ')';
		}
	}
	
}