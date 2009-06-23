package cc.milkshape.grid.square.events
{
	import flash.events.Event;
	
	import cc.milkshape.grid.square.Square;

	public class SquareEvent extends Event
	{
		public static const CREATION:String = 'CREATION';
		public static const FOCUS:String = 'FOCUS';
		public static const FOCUS_OUT:String = 'FOCUS_OUT';
		public static const OVER:String = 'OVER';
		public static const CLICK:String = 'CLICK';
		private var _square:Square;
		private var _shiftKey:Boolean;
		
		public function get shiftKey():Boolean
		{
			return _shiftKey;
		}

		public function set shiftKey(v:Boolean):void
		{
			_shiftKey = v;
		}

		public function get square():Square
		{
			return _square;
		}

		public function set square(v:Square):void
		{
			_square = v;
		}

		public function SquareEvent(eventType:String, square:Square, shiftKey:Boolean = false):void
		{
			super(eventType);
			_square = square;
			_shiftKey = shiftKey;
		}
	}
}