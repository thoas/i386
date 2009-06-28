package cc.milkshape.account.events
{
	import flash.events.Event;
	
	public class CreationsEvent extends Event
	{
		public static const CREATIONS_LOADED:String = 'CREATIONS_LOADED';
		private var _creations:Object;
		public function CreationsEvent(type:String, creations:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_creations = creations;
			super(type, bubbles, cancelable);
		}

		public function get creations():Object
		{
			return _creations;
		}

		public function set creations(v:Object):void
		{
			_creations = v;
		}

	}
}