package
{	
	import cc.milkshape.framework.Application;
	import cc.milkshape.framework.events.ApplicationEvent;
	import cc.milkshape.navigation.generic.ApplicationList;
	import cc.milkshape.navigation.generic.ChannelList;
	import cc.milkshape.navigation.home.HomePlugin;
	
	import com.bourre.events.ApplicationBroadcaster;
	import com.bourre.events.EventBroadcaster;
	import com.bourre.events.EventChannel;
	import com.bourre.plugin.ChannelExpert;
	
	import flash.display.MovieClip;

	public class Home extends Application
	{
		public function Home()
		{	
			super(ApplicationList.HOME, this);
		}
		
		override protected function _applicationLoaded(e:ApplicationEvent):void
		{
			var container:MovieClip = new MovieClip();
			
			ChannelExpert.getInstance().registerChannel(new EventChannel(ChannelList.HOME));
			var home:HomePlugin = new HomePlugin(container);
			
			EventBroadcaster.getInstance().addListener(home.getController());
			ApplicationBroadcaster.getInstance().addListener(this, home.getChannel());
			
			addChild(container);
		}
	}
}