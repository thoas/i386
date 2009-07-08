package cc.milkshape.navigation.home.view
{
	import cc.milkshape.preloader.events.PreloaderEvent;
	import cc.milkshape.utils.Constance;
	
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	public class WelcomeTextUI extends AbstractView
	{
		public function WelcomeTextUI(owner:Plugin=null, name:String=null, mc:DisplayObject=null)
		{
			super(owner, name, mc);
			with(view as WelcomeTextClp)
			{
				moreInfoBtn.buttonMode = true;
				moreInfoBtn.addEventListener(MouseEvent.CLICK, _moreInfoClick);	
			}
		}
		
		private function _moreInfoClick(e:MouseEvent):void
		{
			Main.getInstance().loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, {
				url: Constance.ABOUT_SWF
			}));
		}
	}
}