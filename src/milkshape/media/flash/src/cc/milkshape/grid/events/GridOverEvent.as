package cc.milkshape.grid.events
{
	import flash.events.Event;
	
	public class GridOverEvent extends Event
	{
		public static const OVER:String = 'OVER';
		private var _indice:int;
		
		public function GridOverEvent(e:String, indice:int):void
		{
			super(e);
			_indice = indice;
		}
		
		public function get indice():int
		{
			return _indice;
		}

	}
}

		