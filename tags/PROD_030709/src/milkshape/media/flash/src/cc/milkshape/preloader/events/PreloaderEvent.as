package cc.milkshape.preloader.events
{
	import flash.events.Event;
	
	public class PreloaderEvent extends Event
	{
		public static const INFO:String = 'INFO';
		public static const LOAD:String = 'LOAD';
		private var _option:Object;
		
		public function get option():Object
		{
			return _option;
		}

		public function set option(v:Object):void
		{
			_option = v;
		}

		public function PreloaderEvent(eventType:String, option:Object):void
		{
			super(eventType);
			_option = option;
		}
	}
}

		