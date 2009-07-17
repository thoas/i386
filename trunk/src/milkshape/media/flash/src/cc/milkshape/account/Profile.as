package cc.milkshape.account
{
	import cc.milkshape.account.forms.ProfileForm;
	import cc.milkshape.account.ProfileController;
	
	import flash.display.Sprite;

	public class Profile extends Sprite
	{
		public function Profile()
		{
			var profileController:ProfileController = new ProfileController();
			var profileForm:ProfileForm = new ProfileForm(profileController);
			addChild(profileForm);
		}
	}
}