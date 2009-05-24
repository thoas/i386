package cc.milkshape.grid
{
	import flash.events.Event;
	
	public class GridLineEvent extends Event
	{
		public static const SHOW:String = 'SHOW';
		public static const HIDE:String = 'HIDE';
		
		public function GridLineEvent(e:String):void
		{
			super(e);
		}
		
	}
}

		