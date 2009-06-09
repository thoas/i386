package cc.milkshape.main
{
	import cc.milkshape.preloader.events.PreloaderEvent;
	
	import flash.events.MouseEvent;

	public class SubMenu extends SubMenuClp
	{
		
		public function SubMenu()
		{
			rss.buttonMode = true;
			terms.buttonMode = true;
			rss.slug = 'rss';
			terms.slug = 'terms';
			rss.addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			rss.addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			rss.addEventListener(MouseEvent.CLICK, _clickHandler);
			terms.addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			terms.addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			terms.addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _overHandler(e:MouseEvent):void
		{
			e.currentTarget.gotoAndPlay('over');
		}
		
		private function _outHandler(e:MouseEvent):void
		{
			e.currentTarget.gotoAndPlay('out');
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			trace(e.currentTarget.slug);
			//dispatchEvent(new PreloaderEvent(PreloaderEvent.INFO, e.currentTarget.slug));
		}
		
	}
}