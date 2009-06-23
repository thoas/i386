package cc.milkshape.account
{
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.account.events.PasswordEvent;
	
	public class PasswordController extends GatewayController
	{
		public function update(currentPassword:String, newPassword:String, confirmPassword:String):void
		{
			Gateway.getInstance().call('account.password_change', _responder, currentPassword, newPassword, confirmPassword);
		}
		
		override protected function _onResult(result:Object):void
		{
			if(result){
				this.getUser().setAttribute('account', result);
				dispatchEvent(new PasswordEvent(PasswordEvent.SUCCESS));
			}
		}
	}
}