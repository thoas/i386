package cc.milkshape.grid.events
{
	import flash.events.Event;
	
	public class GridEvent extends Event
	{
		public static const INFO_READY:String = 'INFO_READY';
		public static const READY:String = 'READY';
		private var _nbHSquare:int;
		private var _nbVSquare:int;
		private var _squareSize:int;
		
		public function GridEvent(eventType:String, nbHSquare:int = 0, nbVSquare:int = 0, squareSize:int = 0):void
		{
			super(eventType);
			_nbHSquare = nbHSquare;
			_nbVSquare = nbVSquare;
			_squareSize = squareSize;
		}
		
		public function get squareSize():int
		{
			return _squareSize;
		}

		public function set squareSize(v:int):void
		{
			_squareSize = v;
		}

		public function get nbVSquare():int
		{
			return _nbVSquare;
		}

		public function set nbVSquare(v:int):void
		{
			_nbVSquare = v;
		}

		public function get nbHSquare():int
		{
			return _nbHSquare;
		}

		public function set nbHSquare(v:int):void
		{
			_nbHSquare = v;
		}
	}
}

		