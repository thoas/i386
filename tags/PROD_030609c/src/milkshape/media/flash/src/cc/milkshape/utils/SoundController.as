package cc.milkshape.utils
{
	import cc.milkshape.manager.SoundManager;
	import flash.events.MouseEvent;
	
	public class SoundController extends SoundControllerClip
	{
		private var _enabled:Boolean;
		
		public function SoundController()
		{
			_enabled = true;
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			if(_enabled)
			{
				_enabled = false;
				gotoAndPlay('off');
				SoundManager.getInstance().muteAllSounds();
			}
			else
			{
				_enabled = true;
				gotoAndPlay('on');
				SoundManager.getInstance().unmuteAllSounds();
			}
		}
		
	}
}