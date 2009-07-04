package cc.milkshape.account.events
{
	import flash.events.Event;
	
	public class UpdateViewEvent extends Event
	{
		public static const UPDATE:String = 'UPDATE';
		
		public function UpdateViewEvent(type:String)
		{
			super(type);
		}

	}
}