package cc.milkshape.main.buttons
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class MenuButton extends MenuButtonClp
	{
		private var _overStatut:Boolean;
		private var _clickStatut:Boolean;
		private var _slug:String;
		
		public function MenuButton(labelText:String, slug:String)
		{
			_slug = slug;
			
			buttonMode = true;
			stop();
			_overStatut = false;
			_clickStatut = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
			
			txtClp.label.autoSize = TextFieldAutoSize.LEFT;
			txtClp.label.text = labelText;
			txtClp.over.width = Math.round(txtClp.label.width);		
		}
		
		private function _overHandler(e:MouseEvent):void
		{
			_overStatut = true;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _outHandler(e:MouseEvent):void
		{
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
		
		public function reinitClick():void
		{
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			_outHandler(null);
			_clickStatut = false;
		}
		
		public function initClick():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			_overHandler(null);
			_clickStatut = true;
		}

		private function _clickHandler(e:MouseEvent):void
		{
			if(!_clickStatut)
			{
				dispatchEvent(new Event('CLICKED'));
				removeEventListener(MouseEvent.MOUSE_OVER, _overHandler);
				removeEventListener(MouseEvent.MOUSE_OUT, _outHandler);
				_clickStatut = true;
			}
		}

	}
}