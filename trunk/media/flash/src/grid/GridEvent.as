package grid
{
	import flash.events.Event;
	
	public class GridEvent extends Event
	{
		public static const GRID_READY:String = 'GRID_READY';
		
		public function GridEvent(eventType:String):void
		{
			super(eventType);
		}
	}
}