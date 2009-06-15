package cc.milkshape.artists
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class IssueBtn extends IssueBtnClp
	{
		private var _overStatut:Boolean;
		
		public function IssueBtn()
		{
			buttonMode = true;
			stop();
			_overStatut = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _overHandler(e:MouseEvent):void
		{
			trace('overitem')
			
			dispatchEvent(new Event('OVER'));
			
			_overStatut = true;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _outHandler(e:MouseEvent):void
		{
			trace('outitem')
			
			dispatchEvent(new Event('OUT'));
			
			_overStatut = false;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _enterFrame(e:Event):void
		{
			if (_overStatut) {
				nextFrame();
			} else {
				prevFrame();
			}
			if (currentLabel == 'start' || currentLabel == 'end')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			
		}

		public function get overStatut():Boolean
		{
			return _overStatut;
		}

		public function set overStatut(v:Boolean):void
		{
			_overStatut = v;
		}

	}
}