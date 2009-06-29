package cc.milkshape.user
{
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.preloader.events.PreloaderEvent;
	import cc.milkshape.user.events.LoginEvent;
	import cc.milkshape.utils.Constance;
	
	import flash.net.Responder;

	public class LoginController extends GatewayController
	{
		public function isAuthenticated():void
		{
			_responder = new Responder(_logged, _onFault);
			Gateway.getInstance().call("account.is_authenticated", _responder);
		}
				
		public function login(login:String, password:String):void 
		{
			_responder = new Responder(_logged, _onFault);
			Gateway.getInstance().call("account.login", _responder, login, password);
		}
		
		public function logout():void
		{
			_responder = new Responder(_logout, _onFault);
			Gateway.getInstance().call("account.logout", _responder);
		}
		
		private function _logout(result:Object):void
		{
			dispatchEvent(new LoginEvent(LoginEvent.LOGOUT, result));
			Main.getInstance().loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, {
				url: Constance.HOME_SWF, posX:0, posY:60
			}));
		}
		
		private function _logged(result:Object):void 
		{
			if(result.success)
			{
				this.getUser().setAttribute('account', result.data);
				this.getUser().authenticated = true;
				dispatchEvent(new LoginEvent(LoginEvent.LOGGED, result.data));
			} else {
				if(result.errors)
					dispatchEvent(new LoginEvent(LoginEvent.ERROR, result.errors));
			}
		}
	}
}