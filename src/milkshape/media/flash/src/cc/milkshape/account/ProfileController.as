package cc.milkshape.account
{
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.account.events.ProfileEvent;
	
	public class ProfileController extends GatewayController
	{
		public function update(realname:String, url:String, location:String):void
		{
			Gateway.getInstance().call('profile.profile_change', _responder, realname, url, location);
		}
		
		override protected function _onResult(result:Object):void
		{
			if(result){
				dispatchEvent(new ProfileEvent(ProfileEvent.SUCCESS));
			}
		}
	}
}