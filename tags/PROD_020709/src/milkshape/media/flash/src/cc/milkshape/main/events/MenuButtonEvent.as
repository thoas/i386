package cc.milkshape.main.events
{
	import flash.events.Event;
	
	public class MenuButtonEvent extends Event
	{
		public static const CLICKED:String = 'CLICKED';
		public function MenuButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}