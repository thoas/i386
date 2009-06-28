package cc.milkshape.main
{
	import cc.milkshape.utils.Calcul;
	
	import flash.events.Event;

	public class ErrorArea extends ErrorAreaLabel
	{
		private static var _instance:ErrorArea = null;
		private static const LIST_CHAR:String = '?,;!.:/+-@#&=%^$*azertyuiopqsdfghjklmwxcvbnAZERTYUIOPQSDFGHJKLMWXCVBN1234567890';
		private var _msg:String;
		private var _listChar:String;
		private var _count:int;
		private var _progress:String;
		private var _boolean:Boolean;
		
		public function ErrorArea():void {
			if(_instance != null) 
				throw new Error("Cannot instance this class a second time, use getInstance instead.");
			_instance = this;
			
			label.text = '';
			_progress = '';
		}
		
		public static function getInstance():ErrorArea {
			if(_instance == null)
				new ErrorArea();
			return _instance;
		}
		
		public function putMessage(msg:String):void
		{
			_msg = msg;
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _enterFrame(e:Event):void
		{
			/*if(_count == 1)
			{
				_progress = _msg.charAt(_msg.length - 1) + _progress;
				if (_msg.length == 0)
				{
					removeEventListener(Event.ENTER_FRAME, _enterFrame);
				} 
				else
				{
					_msg = _msg.substr(0, _msg.length - 1);
				}
				_count = 0;
			}
			else 
			{
				if (_msg.length != 0)
					label.text = _listChar.charAt(cc.milkshape.utils.Calcul.randRange(0, _listChar.length)) + _progress;
				else
					label.text = _progress;
				_count++;
			}*/

			_progress = _msg.charAt(_msg.length - 1) + _progress;
			if (_msg.length == 0)
			{
				label.text = _progress;
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			} 
			else
			{
				_msg = _msg.substr(0, _msg.length - 1);
				label.text = LIST_CHAR.charAt(Calcul.randRange(0, LIST_CHAR.length)) + _progress;
			}
		}
	}
}