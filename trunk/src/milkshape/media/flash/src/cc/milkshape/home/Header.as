package cc.milkshape.home
{
	import cc.milkshape.preloader.PreloaderWiper;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class Header extends Sprite
	{
		private var _bgContainer:PreloaderWiper;
		
		public function Header()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);			
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			_bgContainer = new PreloaderWiper();
			addChild(_bgContainer);
			_bgContainer.loadMedia('bg.jpg');
		}
	}
}