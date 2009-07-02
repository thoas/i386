package
{
	import cc.milkshape.preloader.events.PreloaderEvent;
	import cc.milkshape.preloader.PreloaderWiper;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	
	[SWF(width='960', height='600', frameRate='31', backgroundColor='#141414')]
	
	public class Player extends Sprite
	{
		private var _wiperPreloader:PreloaderWiper;
		
		public function Player()
		{
			_wiperPreloader = new PreloaderWiper();
			_wiperPreloader.loadMedia('main.swf');
			addChild(_wiperPreloader);
		}

	}
	
}