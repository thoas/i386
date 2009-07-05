package
{	
	import cc.milkshape.navigation.generic.ChannelList;
	import cc.milkshape.navigation.issue.IssuesPlugin;
	import cc.milkshape.navigation.issue.IssuesFrontController;
	
	import com.bourre.events.ApplicationBroadcaster;
	import com.bourre.events.EventChannel;
	import com.bourre.log.Logger;
	import com.bourre.plugin.ChannelExpert;
	import com.bourre.utils.AirLoggerLayout;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class Issues extends Sprite
	{
		public function Issues()
		{
			Logger.getInstance().addLogListener(AirLoggerLayout.getInstance());
			
			IssuesFrontController.getInstance().init()
			var container:IssuesClp = new IssuesClp();
			
			ChannelExpert.getInstance().registerChannel(new EventChannel(ChannelList.ISSUES));
			var issues:IssuesPlugin = new IssuesPlugin(container);
			
			ApplicationBroadcaster.getInstance().addListener(this, issues.getChannel());
			
			addChild(container);
		}
		
		public function loadIssues(e:Event):void
		{
			Logger.DEBUG( this + ".loadIssues");
		}
	}
}