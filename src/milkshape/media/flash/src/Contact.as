package
{	
	import cc.milkshape.framework.Application;
	import cc.milkshape.framework.events.ApplicationEvent;
	import cc.milkshape.navigation.generic.ApplicationList;
	import cc.milkshape.navigation.generic.ChannelList;
	import cc.milkshape.navigation.about.AboutPlugin;
	
	import com.bourre.events.ApplicationBroadcaster;
	import com.bourre.events.EventBroadcaster;
	import com.bourre.events.EventChannel;
	import com.bourre.plugin.ChannelExpert;
	
	public class Contact extends Application
	{
		public function Contact()
		{	
			super(ApplicationList.CONTACT, this);
		}
		
		override public function applicationLoadedHandler(e:ApplicationEvent):void
		{
			var container:ContactClp = new ContactClp();
			
			ChannelExpert.getInstance().registerChannel(new EventChannel(ChannelList.CONTACT));
			var about:AboutPlugin = new AboutPlugin(container);
			
			EventBroadcaster.getInstance().addListener(about.getController());
			ApplicationBroadcaster.getInstance().addListener(this, about.getChannel());
			
			addChild(container);
		}
	}
}