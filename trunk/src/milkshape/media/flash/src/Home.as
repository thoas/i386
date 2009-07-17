package
{	
	import cc.milkshape.framework.Application;
	import cc.milkshape.framework.events.ApplicationEvent;
	import cc.milkshape.navigation.generic.ApplicationList;
	import cc.milkshape.navigation.generic.ChannelList;
	import cc.milkshape.navigation.generic.PluginsList;
	import cc.milkshape.navigation.home.HomePlugin;
	
	import com.bourre.events.ApplicationBroadcaster;
	import com.bourre.events.EventBroadcaster;
	import com.bourre.events.EventChannel;
	import com.bourre.ioc.bean.BeanFactory;
	import com.bourre.plugin.ChannelExpert;
	import com.bourre.plugin.PluginEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Home extends Application
	{
		public function Home()
		{	
			super(ApplicationList.HOME, this);
		}
		
		override public function applicationLoadedHandler(e:ApplicationEvent):void
		{
			super.applicationLoadedHandler(e);
			var container:MovieClip = new MovieClip();
			
			ChannelExpert.getInstance().registerChannel(new EventChannel(ChannelList.HOME));
			var home:HomePlugin = new HomePlugin(container);
			BeanFactory.getInstance().register(PluginsList.HOME, home);
			
			EventBroadcaster.getInstance().addListener(home.getController());
			ApplicationBroadcaster.getInstance().addListener(this, home.getChannel());
			
			addChild(container);
		}
		
		override public function applicationDisabledHandler(e:Event):void
		{
			EventBroadcaster.getInstance().removeListener(BeanFactory.getInstance().locate(PluginsList.HOME).getController());
			BeanFactory.getInstance().locate(PluginsList.HOME).release();
			_releaseApplication(ApplicationList.HOME, this);
		}
		
		public function onReleasePlugin(e:PluginEvent):void
		{
			BeanFactory.getInstance().unregister(PluginsList.HOME);
		}
	}
}