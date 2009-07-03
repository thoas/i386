package cc.milkshape.account.events
{
	import flash.events.Event;
	
	public class ProfilesEvent extends Event
	{
		public static const SUCCESS:String = 'SUCCESS';
		public static const LAST_PROFILES:String = 'LAST_PROFILES';
		
		private var _lastProfiles:Array;
		public function ProfilesEvent(type:String, lastProfiles:Array=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_lastProfiles = lastProfiles;
			super(type, bubbles, cancelable);
		}

		public function get lastProfiles():Array
		{
			return _lastProfiles;
		}

		public function set lastProfiles(v:Array):void
		{
			_lastProfiles = v;
		}

	}
}