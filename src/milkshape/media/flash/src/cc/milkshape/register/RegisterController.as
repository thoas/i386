package cc.milkshape.register
{
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.user.events.LoginEvent;
	
	import flash.net.Responder;

	public class RegisterController extends GatewayController
	{
		public function signup(username:String, password:String, invitationKey:String):void
		{
			_responder = new Responder(
				function(result:Object):void
				{
					dispatchEvent(new LoginEvent(LoginEvent.LOGGED, result));
				}
			, _onFault)
			Gateway.getInstance().call('account.signup', _responder, username, password, invitationKey);
		}
	}
}