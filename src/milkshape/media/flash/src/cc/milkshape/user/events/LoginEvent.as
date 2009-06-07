package cc.milkshape.user.events
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public static const SUBMIT:String = 'SUBMIT';
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}