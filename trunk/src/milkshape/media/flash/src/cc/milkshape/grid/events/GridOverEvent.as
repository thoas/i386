package cc.milkshape.grid.events
{
	import flash.events.Event;
	
	public class GridOverEvent extends Event
	{
		public static const OVER:String = 'OVER';
		private var _userId:int;
		
		public function GridOverEvent(e:String, userId:int):void
		{
			super(e);
			_userId = userId;
		}
		
		public function get userId():int
		{
			return _userId;
		}

	}
}

		