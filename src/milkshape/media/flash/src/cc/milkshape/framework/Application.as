package cc.milkshape.framework
{
	import cc.milkshape.framework.events.ApplicationEvent;
	
	import com.bourre.log.Logger;
	import com.bourre.utils.AirLoggerLayout;
	
	import flash.display.Sprite;
	
	public class Application extends Sprite
	{
		public function Application(name:String = null, type:Object = null):void
		{
			Logger.getInstance().addLogListener(AirLoggerLayout.getInstance());
			ApplicationFactory.getInstance().addEventListener(ApplicationEvent.LOADED, _applicationLoaded);
			ApplicationFactory.getInstance().register(name, type);
		}
		
		protected function _applicationLoaded(e:ApplicationEvent):void
		{}
	}
}