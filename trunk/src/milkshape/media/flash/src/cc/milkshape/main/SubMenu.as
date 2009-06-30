package cc.milkshape.main
{
	import cc.milkshape.preloader.events.PreloaderEvent;
	import cc.milkshape.utils.Constance;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
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
			rss.addEventListener(MouseEvent.CLICK, _clickHandlerRSS);
			terms.addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			terms.addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			terms.addEventListener(MouseEvent.CLICK, _clickHandlerTerms);
		}
		
		private function _overHandler(e:MouseEvent):void
		{
			e.currentTarget.gotoAndPlay('over');
		}
		
		private function _outHandler(e:MouseEvent):void
		{
			e.currentTarget.gotoAndPlay('out');
		}
		
		private function _clickHandlerTerms(e:MouseEvent):void
		{
			dispatchEvent(new PreloaderEvent(PreloaderEvent.LOAD, {url: Constance.TERMS_SWF}));
		}
		
		private function _clickHandlerRSS(e:MouseEvent):void
		{
			navigateToURL(new URLRequest(Constance.url('/square/feeds/rss/')), 'blank');
		}
		
	}
}