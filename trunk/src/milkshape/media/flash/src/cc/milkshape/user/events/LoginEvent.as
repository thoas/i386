package cc.milkshape.user.events
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public static const SUBMIT:String = 'SUBMIT';
		public static const LOGGED:String = 'LOGGED';
		public static const LOGOUT:String = 'LOGOUT';
		private var _user:Object;
		public function LoginEvent(type:String, user:Object)
		{
			super(type, bubbles, cancelable);
			_user = user;
		}

		public function get user():Object
		{
			return _user;
		}

		public function set user(v:Object):void
		{
			_user = v;
		}

	}
}