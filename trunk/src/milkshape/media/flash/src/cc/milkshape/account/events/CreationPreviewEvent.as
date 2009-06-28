package cc.milkshape.account.events
{
	import flash.events.Event;
	
	public class CreationPreviewEvent extends Event
	{
		public static const CANCEL_CLICKED:String = 'CANCEL_CLICKED';
		private var _posX:int;
		private var _posY:int;
		private var _issueSlug:String;
		public function CreationPreviewEvent(type:String, posX:int, posY:int, issueSlug:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_posX = posX;
			_posY = posY;
			_issueSlug = issueSlug;
			super(type, bubbles, cancelable);
		}

		public function get posY():int
		{
			return _posY;
		}

		public function set posY(v:int):void
		{
			_posY = v;
		}

		public function get issueSlug():String
		{
			return _issueSlug;
		}

		public function set issueSlug(v:String):void
		{
			_issueSlug = v;
		}

		public function get posX():int
		{
			return _posX;
		}

		public function set posX(v:int):void
		{
			_posX = v;
		}

	}
}