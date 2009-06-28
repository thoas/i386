package cc.milkshape.account
{
	import flash.display.Sprite;
	import cc.milkshape.account.ProfileController;
	import cc.milkshape.account.CreationsView;
	public class Creations extends Sprite
	{
		public function Creations()
		{
			var profileController:ProfileController = new ProfileController();
			var creationView:CreationsView = new CreationsView(profileController);
			addChild(creationView);
		}
	}
}