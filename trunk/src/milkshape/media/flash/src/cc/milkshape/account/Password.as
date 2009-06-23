package cc.milkshape.account
{
	import cc.milkshape.account.forms.PasswordForm;
	import cc.milkshape.account.PasswordController;
	import flash.display.Sprite;
	
	public class Password extends Sprite
	{
		public function Password()
		{
			var passwordController:PasswordController = new PasswordController();
			var passwordForm:PasswordForm = new PasswordForm(passwordController);
			addChild(passwordForm);
		}
	}
}