package cc.milkshape.user.forms
{
	import cc.milkshape.framework.forms.Formable;
	import cc.milkshape.user.events.LoginEvent;
	import cc.milkshape.manager.KeyboardManager;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class LoginForm extends LoginFormClp implements Formable
	{
		
		public function LoginForm()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
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
			loginForm.submit.addEventListener(MouseEvent.CLICK, function():void {
				dispatchEvent(new LoginEvent(LoginEvent.SUBMIT));
			});
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