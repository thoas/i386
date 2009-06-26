package cc.milkshape.grid.process.events
{
	import flash.events.Event;

	public class SquareProcessEvent extends Event
	{
		public static const DOWNLOAD:String = 'DOWNLOAD';
		public static const UPLOADING:String = 'UPLOADING';
		public static const UPLOADING2:String = 'UPLOADING2';
		public static const SUCCESS:String = 'SUCCESS';
		public static const CANCELED:String = 'CANCELED';
		public static const BOOKED:String = 'BOOKED';
		public static const SHOW:String = 'SHOW';
		public static const HIDE:String = 'HIDE';
		
		public function SquareProcessEvent(eventType:String)
		{
			super(eventType);
		}
	}
}