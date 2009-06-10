package cc.milkshape.grid.square
{	
	public class SquareFull extends Square
	{		
		private var _layers:Object;
		public function SquareFull(x:int, y:int, url:String, size:int)
		{
			super(x, y, 0x000000, size);
		}

		public function get layers():Object
		{
			return _layers;
		}

		public function set layers(v:Object):void
		{
			_layers = v;
		}

	}
}