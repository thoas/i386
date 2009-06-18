package cc.milkshape.preloader.events
{
	import flash.events.Event;
	
	public class PreloaderEvent extends Event
	{
		public static const INFO:String = 'INFO';
		public static const LOAD:String = 'LOAD';
		private var _msg:String;
		
		public function get msg():String
		{
			return _msg;
		}

		public function set msg(v:String):void
		{
			_msg = v;
		}

		public function PreloaderEvent(eventType:String, msg:String):void
		{
			super(eventType);
			_msg = msg;
		}
	}
}

		