package cc.milkshape.grid.square
{
	import flash.events.Event;
	
	public class SquareEvent extends Event
	{
		public static const CREATION:String = 'CREATION';
		public static const FOCUS:String = 'FOCUS';
		public static const OVER:String = 'OVER';
		private var _square:Square;
		
		public function SquareEvent(eventType:String, square:Square):void
		{
			super(eventType);
			_square = square;
		}
		
		public function get square():Square { return _square }
	}
}