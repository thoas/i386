package cc.milkshape.account.events
{
	import flash.events.Event;
	
	public class AccountMenuButtonEvent extends Event
	{
		public static const CLICKED:String = 'CLICKED';
		public function AccountMenuButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}