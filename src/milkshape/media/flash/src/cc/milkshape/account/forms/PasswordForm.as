package cc.milkshape.account.forms
{
	import cc.milkshape.account.PasswordController;
	import cc.milkshape.account.events.PasswordEvent;
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.framework.forms.Formable;
	import cc.milkshape.framework.forms.fields.LabelInput;
	
	import flash.events.MouseEvent;

	public class PasswordForm extends PasswordClp implements Formable
	{
		private var _passwordController:PasswordController;
		private var _update:SmallButton;
		private var _currentPassword:LabelInput;
		private var _newPassword:LabelInput;
		private var _confirmPassword:LabelInput;
		public function PasswordForm(passwordController:PasswordController)
		{
			_passwordController = passwordController;
			_currentPassword = new LabelInput('CURRENT PASSWORD:', true);
			_newPassword = new LabelInput('NEW PASSWORD:', true);
			_confirmPassword = new LabelInput('CONFIRMATION PASSWORD:', true);
			_update = new SmallButton('UPDATE', new PlusItem());
			newPassword.addChild(_newPassword);
			confirmPassword.addChild(_confirmPassword);
			currentPassword.addChild(_currentPassword);
			update.addChild(_update);
			
			update.addEventListener(MouseEvent.CLICK, _updateHandler);
			_passwordController.addEventListener(PasswordEvent.SUCCESS, _updated);
		}
		
		private function _updateHandler(e:MouseEvent):void
		{
			_passwordController.update(_currentPassword.text, _newPassword.text, _confirmPassword.text);
		}
		
		public function values():Object
		{
			return {
				'currentPassword': _currentPassword.text,
				'newPassword': _newPassword.text,
				'confirmPassword': _confirmPassword.text
			};
		}
		
		public function reset():void
		{
			_currentPassword.blur();
			_newPassword.blur();
			_confirmPassword.blur();
		}
		
		private function _updated(e:PasswordEvent):void
		{
			reset();
		}
	}
}