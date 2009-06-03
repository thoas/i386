package cc.milkshape.grid.square
{
	import flash.events.Event;
	
	public class SquareEvent extends Event
	{
		public static const CREATION:String = 'CREATION';
		public static const FOCUS:String = 'FOCUS';
		public static const OVER:String = 'OVER';
		public static const CLICK:String = 'CLICK';
		private var _square:Square;
		private var _shiftKey:Boolean;
		
		public function SquareEvent(eventType:String, square:Square, shiftKey:Boolean = false):void
		{
			super(eventType);
			_square = square;
			_shiftKey = shiftKey;
		}
		
		public function get square():Square { return _square }
		
		public function get shiftKey():Boolean { return _shiftKey }
	}
}