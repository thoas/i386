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
			super();
			getController().pushCommandClass(PrivateEventList.onClickIssuePreviewUI, OnClickIssuePreviewUI);
			getController().pushCommandClass(PrivateEventList.onLoadIssuesUI, OnLoadIssuesUI);
			_container = container;
			
			var issuesUI:IssuesUI = new IssuesUI(this, UIList.ISSUES_UI, _container);
		}
	}
}