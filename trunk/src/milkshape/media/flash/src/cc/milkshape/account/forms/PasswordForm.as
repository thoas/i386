package cc.milkshape.account.forms
{
	import cc.milkshape.account.PasswordController;
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.framework.forms.fields.Input;

	public class PasswordForm extends PasswordClp
	{
		private var _passwordController:PasswordController;
		private var _update:SmallButton;
		private var _currentPassword:Input;
		private var _newPassword:Input;
		private var _confirmPassword:Input;
		public function PasswordForm(passwordController:PasswordController)
		{
			_passwordController = passwordController;
			_currentPassword = new Input('CURRENT PASSWORD');
			_newPassword = new Input('PASSWORD');
			_confirmPassword = new Input('CONFIRMATION PASSWORD');
			_update = new SmallButton('UPDATE', new PlusItem());
			newPassword.addChild(_newPassword);
			confirmPassword.addChild(_confirmPassword);
			currentPassword.addChild(_currentPassword);
			update.addChild(_update);
		}
	}
}