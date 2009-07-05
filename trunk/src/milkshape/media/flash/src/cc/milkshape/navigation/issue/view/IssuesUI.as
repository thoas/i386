package cc.milkshape.navigation.issue.view
{
	import cc.milkshape.navigation.generic.PluginsEventList;
	import cc.milkshape.navigation.generic.PrivateEventList;
	
	import com.bourre.events.BasicEvent;
	import com.bourre.events.EventBroadcaster;
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class IssuesUI extends AbstractView
	{
		public function IssuesUI(owner:Plugin=null, name:String=null, mc:DisplayObject=null)
		{
			super(owner, name, mc);
			if(mc)
			{
				mc.addEventListener(Event.ADDED_TO_STAGE, _initUI);
			}
		}
		
		private function _initUI(e:Event):void
		{
			getLogger().debug('owner: ' + getOwner());
			getOwner().firePublicEvent(new BasicEvent(PluginsEventList.loadIssuesEvent, this));
			EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(PrivateEventList.onLoadIssuesUI, this));
		}
	}
}