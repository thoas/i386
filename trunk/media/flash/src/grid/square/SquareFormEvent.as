package grid.square
{
	import flash.events.Event;
	import grid.square.Square;
	
	public class SquareFormEvent extends Event
	{
		public static const SHOW_OPEN:String = 'SHOW_OPEN';
		public static const SHOW_BOOKED:String = 'SHOW_BOOKED';
		public static const CLOSE:String = 'CLOSE';
		
		public function SquareFormEvent(eventType:String):void
		{
			super(eventType);
		}
		
	}
}