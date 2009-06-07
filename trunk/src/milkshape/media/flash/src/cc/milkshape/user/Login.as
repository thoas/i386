package cc.milkshape.user
{
	import flash.display.Sprite;
	import flash.events.Event;
	import cc.milkshape.user.forms.LoginForm;
	

	public class Login extends Sprite
	{		
		private var _loginController:LoginController;
		private var _loginForm:LoginForm;
		public function Login()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		public function _handlerAddedToStage(e:Event):void {
			_loginForm = new LoginForm();
			_loginForm.x = 200;
			
			_loginController = new LoginController(_loginForm);
			addChild(_loginForm);
		}
		
		
	}
}