package cc.milkshape.navigation.home.view
{
	import cc.milkshape.navigation.generic.PrivateEventList;
	
	import com.bourre.plugin.Plugin;
	import com.bourre.events.EventBroadcaster;
	import com.bourre.events.ObjectEvent;
	import com.bourre.view.AbstractView;
	import com.bourre.ioc.bean.BeanFactory;
	
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
				moreInfoBtn.addEventListener(MouseEvent.CLICK, _clickHandler);	
			}
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			EventBroadcaster.getInstance().broadcastEvent(new ObjectEvent(PrivateEventList.loadApplication, {
				url: BeanFactory.getInstance().locate('ABOUT_SWF') as String
			}));
		}
	}
}