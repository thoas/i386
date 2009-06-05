package cc.milkshape.grid
{
	import flash.events.Event;
	
	public class GridZoomEvent extends Event
	{
		public static const ZOOM:String = 'ZOOM';
		private var _currentScale:int;
		
		public function get currentScale():int
		{
			return _currentScale;
		}

		public function set currentScale(v:int):void
		{
			_currentScale = v;
		}

		public function GridZoomEvent(e:String, currentScale:int):void
		{
			super(e);
			_currentScale = currentScale;
		}
	}
}

		