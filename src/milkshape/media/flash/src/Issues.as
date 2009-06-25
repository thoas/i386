package
{	
	import cc.milkshape.issue.IssueController;
	import cc.milkshape.issue.IssuesView;
	import flash.display.Sprite;

	public class Issues extends Sprite
	{
		public function Issues()
		{
			var issueController:IssueController = new IssueController();
			var issueView:IssuesView = new IssuesView(issueController);
			addChild(issueView);
		}
	}
}