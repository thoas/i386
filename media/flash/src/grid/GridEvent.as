package grid
{
	import flash.events.Event;
	
	public class GridEvent extends Event
	{
		public static const GRID_READY:String = 'GRID_READY';
		public static const GRID_UPDATE:String = 'GRID_UPDATE';
		public static const GRID_OPEN_SQUARE:String = 'GRID_OPEN_SQUARE';
		public static const GRID_BOOKED_SQUARE:String = 'GRID_BOOKED_SQUARE';
		private var _currentScale:int;
		
		public function GridEvent(eventType:String, currentScale:int = void):void
		{
			super(eventType);
			_currentScale = currentScale;
		}
		
		public function get currentScale():int { return _currentScale }
	}
}

		