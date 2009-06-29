package cc.milkshape.user.events
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public static const SUBMIT:String = 'SUBMIT';
		public static const LOGGED:String = 'LOGGED';
		public static const ERROR:String = 'ERROR';
		public static const LOGOUT:String = 'LOGOUT';
		private var _result:Object;
		public function LoginEvent(type:String, result:Object)
		{
			super(type, bubbles, cancelable);
			_result = result;
		}

		public function get result():Object
		{
			return _result;
		}

		public function set result(v:Object):void
		{
			_result = v;
		}

	}
}