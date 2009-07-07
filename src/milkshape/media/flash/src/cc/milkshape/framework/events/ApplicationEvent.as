package cc.milkshape.framework.events
{
	import flash.events.Event;
	
	public class ApplicationEvent extends Event
	{
		public static const LOADED:String = 'LOADED';
		public function ApplicationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}