package cc.milkshape.register
{
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.user.events.LoginEvent;
	
	import flash.net.Responder;

	public class RegisterController extends GatewayController
	{
		public function signup(username:String, email:String, password:String, confirmPassword:String, ticket:String):void
		{
			_responder = new Responder(
				function(result:Object):void
				{
					if(result.success)
					{
						dispatchEvent(new LoginEvent(LoginEvent.LOGGED, result.data));
					} else {
						dispatchEvent(new LoginEvent(LoginEvent.ERROR, result.errors));
					}
					// look result.errors for errors list
				}
			, _onFault)
			Gateway.getInstance().call('account.signup', _responder, username, email, password, confirmPassword, ticket);
		}
	}
}