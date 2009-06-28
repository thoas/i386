package cc.milkshape.user
{
	import flash.display.Sprite;
	import flash.events.Event;
	import cc.milkshape.user.forms.LoginForm;
	

	public class Login extends Sprite
	{		
		public function Login()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		public function _handlerAddedToStage(e:Event):void 
		{
			var loginController:LoginController = new LoginController();
			var loginForm:LoginForm = new LoginForm(loginController);
			addChild(loginForm);
		}
	}
}