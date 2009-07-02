package cc.milkshape.main.buttons
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import cc.milkshape.main.events.MenuButtonEvent;
	import flash.text.TextFieldAutoSize;
	
	public class MenuButton extends MenuButtonClp
	{
		private var _overStatus:Boolean;
		private var _clickStatus:Boolean;
		private var _option:Object;
		
		public function MenuButton(labelText:String, option:Object)
		{
			_option = option;
			
			buttonMode = true;
			stop();
			_overStatus = false;
			_clickStatus = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
			
			txtClp.label.autoSize = TextFieldAutoSize.LEFT;
			txtClp.label.text = labelText;
			txtClp.over.width = Math.round(txtClp.label.width);		
		}
		
		public function get option():Object
		{
			return _option;
		}

		public function set option(v:Object):void
		{
			_option = v;
		}

		private function _overHandler(e:MouseEvent):void
		{
			_overStatus = true;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _outHandler(e:MouseEvent):void
		{
			_overStatus = false;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _enterFrame(e:Event):void
		{
			if (_overStatus) {
				nextFrame();
			} else {
				prevFrame();
			}
			if (currentLabel == 'start' || currentLabel == 'end')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
		
		public function reinitClick():void
		{
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			_outHandler(null);
			_clickStatus = false;
		}
		
		public function initClick():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			_overHandler(null);
			_clickStatus = true;
		}

		private function _clickHandler(e:MouseEvent):void
		{
			dispatchEvent(new MenuButtonEvent(MenuButtonEvent.CLICKED));
			removeEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, _outHandler);
		}
	}
}