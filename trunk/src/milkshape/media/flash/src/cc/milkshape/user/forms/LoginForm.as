package cc.milkshape.user.forms
{
	import cc.milkshape.framework.forms.Formable;
	import cc.milkshape.manager.KeyboardManager;
	import cc.milkshape.user.LoginController;
	import cc.milkshape.user.events.LoginEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;

	public class LoginForm extends LoginFormClp implements Formable
	{
		private var _loginController:LoginController;
		public function LoginForm(loginController:LoginController)
		{
			_loginController = loginController;
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
			_loginController.addEventListener(LoginEvent.LOGGED, _logged);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			loginBtn.buttonMode = true;
			loginBtn.addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			KeyboardManager.enabled = false;
			gotoAndStop('form');
			loginForm.password.txt.displayAsPassword = true;
			loginForm.submit.buttonMode = true;
			loginForm.submit.addEventListener(MouseEvent.CLICK, _login);
        }
        
        private function _logged(e:LoginEvent):void {
        	var user:Object = e.user;
        	MonsterDebugger.trace(this, user);
        }
        
        private function _login(e:MouseEvent):void
        {
        	_loginController.login(loginForm.login.txt.text, loginForm.password.txt.text);
        }
		
		public function values():Object
		{
			return {
				'login': loginForm.login.txt.text,
				'password': loginForm.password.txt.text
			};
		}
		
	}
}