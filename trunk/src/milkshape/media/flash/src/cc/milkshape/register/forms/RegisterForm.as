package cc.milkshape.register.forms
{	
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.framework.forms.Formable;
	import cc.milkshape.framework.forms.fields.Checkbox;
	import cc.milkshape.framework.forms.fields.LabelInput;
	import cc.milkshape.register.RegisterController;
	
	import flash.events.MouseEvent;

	public class RegisterForm extends RegisterClp implements Formable
	{
		private var _registerController:RegisterController;
		private var _username:LabelInput;
		private var _email:LabelInput;
		private var _password:LabelInput;
		private var _confirmPassword:LabelInput;
		private var _invitationKey:LabelInput;
		private var _checkTerms:Checkbox;
		private var _submit:SmallButton;
		public function RegisterForm(registerController:RegisterController)
		{
			_registerController = registerController;
			_username = new LabelInput('USERNAME *');
			username.addChild(_username);
			_email = new LabelInput('EMAIL *');
			email.addChild(_email);
			_password = new LabelInput('PASSWORD *');
			password.addChild(_password);
			_confirmPassword = new LabelInput('PASSWORD CONFIRMATION *');
			confirmPassword.addChild(_confirmPassword);
			
			_checkTerms = new Checkbox();
			checkTerms.addChild(_checkTerms);
			
			_submit = new SmallButton('VALID MY SUBSCRIPTION', new PlusItem());
			submit.addChild(_submit);
			
			_submit.addEventListener(MouseEvent.CLICK, _submitHandler);
		}
		
		private function _submitHandler(e:MouseEvent):void
		{
			_registerController.signup(_username.text, _email.text, _password.text, _confirmPassword.text, ticket.text);
		}
		
		public function values():Object
		{
			return {
				'username': _username.text,
				'email': _email.text,
				'password': _password.text,
				'confirmPassword': _confirmPassword.text,
				'invitationKey': ticket.text
			};
		}
		
		public function reset():void
		{
			_username.blur()
			_password.blur();
			_confirmPassword.blur();
			_invitationKey.blur();
		}
	}
}