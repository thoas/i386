package grid.square
{
	import flash.events.Event;
	
	import grid.square.Square;
	
	public class SquareEvent extends Event
	{
		public static const SQUARE_CREATION:String = 'SQUARE_CREATION';
		public static const SQUARE_FOCUS:String = 'SQUARE_FOCUS';
		public static const SQUARE_MOVE:String = 'SQUARE_MOVE';
		private var _square:Square;
		
		public function SquareEvent(eventType:String, square:Square):void
		{
			_square = square;
			super(eventType);
		}

		public function get square():Square
		{
			return _square;
		}
	}
}