package cc.milkshape.preloader
{
	import flash.events.Event;
	
	public class PreloaderEvent extends Event
	{
		public static const INFO:String = 'INFO';
		private var _msg:String;
		
		public function PreloaderEvent(eventType:String, msg:String):void
		{
			super(eventType);
			_msg = msg;
		}
		
		public function get msg():String { return _msg }
	}
}

		