package cc.milkshape.grid.square.events
{
	import cc.milkshape.grid.square.Square;
	
	import flash.events.Event;
	
	public class SquareFormEvent extends Event
	{
		public static const SHOW_OPEN:String = 'SHOW_OPEN';
		public static const SHOW_BOOKED:String = 'SHOW_BOOKED';
		public static const CLOSE:String = 'CLOSE';
		
		private var _focusSquare:*;
		
		public function get focusSquare():*
		{
			return _focusSquare;
		}

		public function set focusSquare(v:*):void
		{
			_focusSquare = v;
		}

		public function SquareFormEvent(eventType:String, focusSquare:*):void
		{
			super(eventType);
			_focusSquare = focusSquare;
		}
	}
}