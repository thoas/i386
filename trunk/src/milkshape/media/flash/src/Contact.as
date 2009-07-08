package
{	
	import cc.milkshape.framework.Application;
	import cc.milkshape.framework.events.ApplicationEvent;
	import cc.milkshape.navigation.generic.ApplicationList;
	import cc.milkshape.navigation.generic.ChannelList;
	import cc.milkshape.navigation.contact.ContactPlugin;
	
	import com.bourre.events.ApplicationBroadcaster;
	import com.bourre.events.EventBroadcaster;
	import com.bourre.events.EventChannel;
	import com.bourre.plugin.ChannelExpert;
	
	import flash.display.MovieClip;

	public class Contact extends Application
	{
		public function Contact()
		{	
			super(ApplicationList.CONTACT, this);
		}
		
		override protected function _applicationLoaded(e:ApplicationEvent):void
		{
			var container:ContactClp = new ContactClp();
			
			ChannelExpert.getInstance().registerChannel(new EventChannel(ChannelList.CONTACT));
			var contact:ContactPlugin = new ContactPlugin(container);
			
			EventBroadcaster.getInstance().addListener(contact.getController());
			ApplicationBroadcaster.getInstance().addListener(this, contact.getChannel());
			
			addChild(container);
		}
	}
}