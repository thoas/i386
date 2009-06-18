package cc.milkshape.user
{
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.user.events.LoginEvent;

	public class LoginController extends GatewayController
	{
		public function LoginController():void
		{
		}
		
		public function login(login:String, password:String):void 
		{
			_connect("account/gateway/");
			_gateway.call("account.login", _responder, login, password);
		}
		
		override protected function _onResult(result:Object):void 
		{
			this.getUser().setAttribute('account', result);
			dispatchEvent(new LoginEvent(LoginEvent.LOGGED, result));
		}
	}
}