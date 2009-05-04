package grid
{
	import flash.events.Event;
	
	public class GridMoveEvent extends Event
	{
		public static const MOVE:String = 'MOVE';
		private var _decalX:Number;
		private var _decalY:Number;
		
		public function GridMoveEvent(e:String, decalX:Number, decalY:Number):void
		{
			super(e);
			_decalX = decalX;
			_decalY = decalY;
		}
		
		public function get decalX():Number { return _decalX }
		
		public function get decalY():Number { return _decalY }
	}
}

		