package
{
	import cc.milkshape.home.HomeView;
	import cc.milkshape.issue.IssueController;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Home extends Sprite
	{	
		public function Home()
		{
			var issueController:IssueController = new IssueController();
			var homeView:HomeView = new HomeView(issueController);		
			addChild(homeView);	
		}
	}
}