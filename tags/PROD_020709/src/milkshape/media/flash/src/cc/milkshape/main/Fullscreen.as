package cc.milkshape.main
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Fullscreen extends FullscreenClp
	{
		private var _enabled:Boolean;
		private var _overStatut:Boolean;
		
		public function Fullscreen()
		{
			stop();
			buttonMode = true;			
			_enabled = true;
			_overStatut = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
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
			if (_overStatut)
				nextFrame();
			else
				prevFrame();

			if (currentLabel == 'start' || currentLabel == 'end')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			if(_enabled)
			{
				stage.displayState = 'fullScreen';
				removeEventListener(MouseEvent.MOUSE_OVER, _overHandler);
				removeEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			}
			else
			{
				addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
				addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
				stage.displayState = 'normal';
			}
			_enabled = !_enabled;
			
		}
	}
}