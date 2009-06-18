package cc.milkshape.main
{
	import cc.milkshape.manager.SoundManager;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Equalizer extends EqualizerClp
	{
		private var _enabled:Boolean;
		
		public function Equalizer()
		{
			stop();
			buttonMode = true;
			_enabled = true;
			
			addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _enterFrame(e:Event):void
		{
			if (_enabled)
				prevFrame();
			else
				nextFrame();

			if (currentLabel == 'start' || currentLabel == 'end')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			if(_enabled)
				SoundManager.getInstance().muteAllSounds();
			else
				SoundManager.getInstance().unmuteAllSounds();
				
			_enabled = !_enabled;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
	}
}