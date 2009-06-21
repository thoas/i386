package cc.milkshape.user
{
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.user.events.LoginEvent;
	
	import flash.net.Responder;

	public class LoginController extends GatewayController
	{
		public function LoginController():void
		{
		}
		
		public function isAuthenticated():void
		{
			Gateway.getInstance().call("account.is_authenticated", _responder);
		}
		
		public function login(login:String, password:String):void 
		{
			Gateway.getInstance().call("account.login", _responder, login, password);
		}
		
		public function logout():void
		{
			_responder = new Responder(_logoutResult, _onFault);
			Gateway.getInstance().call("account.logout", _responder);
		}
		
		private function _logoutResult(result:Object):void
		{
			dispatchEvent(new LoginEvent(LoginEvent.LOGOUT, result));
		}
		
		override protected function _onResult(result:Object):void 
		{
			if(result){
				this.getUser().setAttribute('account', result);
				this.getUser().authenticated = true;
				dispatchEvent(new LoginEvent(LoginEvent.LOGGED, result));
			}
		}
	}
}