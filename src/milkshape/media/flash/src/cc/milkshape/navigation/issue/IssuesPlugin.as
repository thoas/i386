package cc.milkshape.navigation.issue
{
	import cc.milkshape.navigation.generic.PrivateEventList;
	import cc.milkshape.navigation.generic.UIList;
	import cc.milkshape.navigation.issue.cmd.OnClickIssuePreviewUI;
	import cc.milkshape.navigation.issue.cmd.OnLoadIssuesUI;
	import cc.milkshape.navigation.issue.view.IssuesUI;
	
	import com.bourre.events.BasicEvent;
	import com.bourre.plugin.AbstractPlugin;
	
	import flash.display.Sprite;

	public class IssuesPlugin extends AbstractPlugin
	{
		private var _container:Sprite;
		public function IssuesPlugin(container:Sprite)
		{
			_container = container;
			super();
			getController().pushCommandClass(PrivateEventList.onLoadIssuesUI, OnLoadIssuesUI);
			getController().pushCommandClass(PrivateEventList.onClickIssuePreviewUI, OnClickIssuePreviewUI);
			getLogger().debug('issuesPlugin');
			var issuesUI:IssuesUI = new IssuesUI(this, UIList.ISSUES, _container);
		}
	}
}