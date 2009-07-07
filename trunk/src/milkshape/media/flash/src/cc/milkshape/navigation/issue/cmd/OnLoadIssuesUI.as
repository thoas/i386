package cc.milkshape.navigation.issue.cmd
{
	import cc.milkshape.framework.remoting.ServerAbstractCommand;
	import cc.milkshape.navigation.generic.UIList;
	import cc.milkshape.navigation.generic.PluginsServiceList;
	import cc.milkshape.navigation.issue.IssuesPluginService;
	import cc.milkshape.framework.remoting.ProxyService;
	import cc.milkshape.navigation.issue.view.IssuesUI;
	import com.bourre.remoting.events.BasicResultEvent;
	
	import flash.events.Event;

	public class OnLoadIssuesUI extends ServerAbstractCommand
	{
		override public function execute(e:Event = null):void
		{
			IssuesPluginService(ProxyService.getInstance().locate(PluginsServiceList.issuesPlugin)).lastIssues(this); 
		}
		
		override public function onResult(e:BasicResultEvent):void
		{
			IssuesUI(getView(UIList.ISSUES)).init(e.getResult());
		}
	}
}