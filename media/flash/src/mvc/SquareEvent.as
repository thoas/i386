package mvc
{
	import flash.events.Event;
	
	import grid.square.Square;
	
	public class SquareEvent extends Event
	{
		public const SQUARE_CREATION:String = 'SQUARE_CREATION';
		private var _square:Square;
		public function SquareEvent(eventType:String, square:Square)
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