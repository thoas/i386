package
{	
	import cc.milkshape.framework.Application;
	import cc.milkshape.framework.events.ApplicationEvent;
	import cc.milkshape.navigation.generic.ApplicationList;
	import cc.milkshape.navigation.generic.ChannelList;
	import cc.milkshape.navigation.issue.IssuesPlugin;
	
	import com.bourre.events.ApplicationBroadcaster;
	import com.bourre.events.EventBroadcaster;
	import com.bourre.events.EventChannel;
	import com.bourre.plugin.ChannelExpert;

	public class Issues extends Application
	{
		public function Issues()
		{	
			super(ApplicationList.ISSUES, this);
		}
		
		override protected function _applicationLoaded(e:ApplicationEvent):void
		{
			var container:IssuesClp = new IssuesClp();
			
			ChannelExpert.getInstance().registerChannel(new EventChannel(ChannelList.ISSUES));
			var issues:IssuesPlugin = new IssuesPlugin(container);
			
			EventBroadcaster.getInstance().addListener(issues.getController());
			ApplicationBroadcaster.getInstance().addListener(this, issues.getChannel());
			
			addChild(container);
		}
	}
}