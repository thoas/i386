package cc.milkshape.framework.buttons
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class SmallButton extends SmallButtonClp
	{
		private var _overStatut:Boolean;
		private var _itemClp:*;
		
		public function SmallButton(labelText:String, itemClp:*)
		{
			_itemClp = itemClp;
			item.addChild(_itemClp);
			
			buttonMode = true;
			stop();
			_itemClp.stop();
			_overStatut = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			
			label.autoSize = TextFieldAutoSize.LEFT;
			label.text = labelText;
			over.width = bg.shape.width = Math.round(label.width) + 22;			
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
				_itemClp.nextFrame();
			} else {
				prevFrame();
				_itemClp.prevFrame();
			}
			if (currentLabel == 'start' || currentLabel == 'end')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
	}
}