package cc.milkshape.user
{
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.user.forms.LoginForm;
	import cc.milkshape.user.events.LoginEvent;
	import cc.milkshape.gateway.vo.UserVO;
	
	public class LoginController extends GatewayController
	{
		private var _loginForm:LoginForm;
		private static var _user:Object;
		public function LoginController(loginForm:LoginForm):void
		{
			_loginForm = loginForm;
			_loginForm.addEventListener(LoginEvent.SUBMIT, _login);
		}
		
		public function _login(e:LoginEvent):void {
			var params:Object = _loginForm.values();
			_gateway.connect("http://localhost:8000/account/gateway/");
			_gateway.call("account.login", _responder, params.login, params.password);
		}
		
		override protected function _onResult(result:Object):void {
			trace('result' + result);
			//var user:UserVO = result as UserVO;
			//trace(user);
			_user = result;
		}
	}
}