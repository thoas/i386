package cc.milkshape.grid
{
	import flash.events.Event;
	
	public class GridMoveEvent extends Event
	{
		public static const MOVE:String = 'MOVE';
		private var _decalX:Number;
		private var _decalY:Number;
		
		public function get decalY():Number
		{
			return _decalY;
		}

		public function set decalY(v:Number):void
		{
			_decalY = v;
		}

		public function get decalX():Number
		{
			return _decalX;
		}

		public function set decalX(v:Number):void
		{
			_decalX = v;
		}

		public function GridMoveEvent(e:String, decalX:Number, decalY:Number):void
		{
			super(e);
			_decalX = decalX;
			_decalY = decalY;
		}
	}
}

		