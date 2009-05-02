package grid
{
	import flash.events.Event;
	
	public class GridEvent extends Event
	{
		public static const GRID_READY:String = 'GRID_READY';
		public static const GRID_UPDATE:String = 'GRID_UPDATE';
		private var _currentScale:int;
		
		public function GridEvent(eventType:String, currentScale:int):void
		{
			super(eventType);
			_currentScale = currentScale;
		}
		
		public function get currentScale():int { return _currentScale }
	}
}

		