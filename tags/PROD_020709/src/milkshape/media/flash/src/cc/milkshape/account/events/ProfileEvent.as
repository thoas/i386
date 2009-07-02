package cc.milkshape.account.events
{
	import flash.events.Event;
	
	public class ProfileEvent extends Event
	{
		public static const PROFILE:String = 'PROFILE';
		private var _result:Object;
		public function ProfileEvent(type:String, result:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_result = result;
			super(type, bubbles, cancelable);
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