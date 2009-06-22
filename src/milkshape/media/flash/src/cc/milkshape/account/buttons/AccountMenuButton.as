package cc.milkshape.account.buttons
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import cc.milkshape.account.events.AccountMenuButtonEvent;
	
	public class AccountMenuButton extends AccountMenuBtnClp
	{
		private var _nextFrame:Boolean;
		private var _params:Object;
		
		public function AccountMenuButton(o:Object)
		{
			_params = o;
			stop();
			buttonMode = true;
			textClp.label.text = _params.label;
			
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _overHandler(e:MouseEvent):void
		{			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _outHandler(e:MouseEvent):void
		{			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _enterFrame(e:Event):void
		{
			if (_nextFrame) {
				nextFrame();
			} else {
				prevFrame();
			}
			if (currentLabel == 'start' || currentLabel == 'end')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
		
		public function initClick():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			removeEventListener(MouseEvent.CLICK, _clickHandler);
			_nextFrame = true;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		public function reinitClick():void
		{
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
			_nextFrame = false;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			dispatchEvent(new AccountMenuButtonEvent(AccountMenuButtonEvent.CLICKED));
		}

		public function get params():Object
		{
			return _params;
		}

		public function set params(v:Object):void
		{
			_params = v;
		}

	}
}