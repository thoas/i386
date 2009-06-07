package cc.milkshape.user
{
	import nl.demonsters.debugger.MonsterDebugger;
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.user.forms.LoginForm;
	import cc.milkshape.user.events.LoginEvent;
	import cc.milkshape.gateway.vo.UserVO;
	import cc.milkshape.manager.UserManager;
	
	public class LoginController extends GatewayController
	{
		private var _loginForm:LoginForm;
		public function LoginController(loginForm:LoginForm):void
		{
			_loginForm = loginForm;
			_loginForm.addEventListener(LoginEvent.SUBMIT, _login);
		}
		
		public function _login(e:LoginEvent):void 
		{
			var params:Object = _loginForm.values();
			_connect("account/gateway/");
			_gateway.call("account.login", _responder, params.login, params.password);
		}
		
		override protected function _onResult(result:Object):void 
		{
			MonsterDebugger.trace(this, result);
			UserManager.setUser(result);
		}
	}
}