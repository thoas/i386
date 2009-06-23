package cc.milkshape.account.events
{
	import flash.events.Event;
	
	public class PasswordEvent extends Event
	{
		public static const SUCCESS:String = 'SUCCESS';
		public function PasswordEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}