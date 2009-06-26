package
{
	import cc.milkshape.account.ProfileController;
	import cc.milkshape.home.HomeView;
	import cc.milkshape.issue.IssueController;
	
	import flash.display.Sprite;

	public class Home extends Sprite
	{	
		public function Home()
		{
			var issueController:IssueController = new IssueController();
			var profileController:ProfileController = new ProfileController();
			var homeView:HomeView = new HomeView(issueController, profileController);		
			addChild(homeView);	
		}
	}
}