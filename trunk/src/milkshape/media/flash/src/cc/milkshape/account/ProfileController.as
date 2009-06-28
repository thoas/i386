package cc.milkshape.account
{
	import cc.milkshape.account.events.CreationsEvent;
	import cc.milkshape.account.events.ProfileEvent;
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.gateway.GatewayController;
	
	import flash.net.Responder;

	public class ProfileController extends GatewayController
	{
		public function update(realname:String, url:String, location:String):void
		{
			_responder = new Responder(_updated, _onFault);
			Gateway.getInstance().call('profile.profile_change', _responder, realname, url, location);
		}
		
		public function lastProfiles():void
		{
			_responder = new Responder(_lastProfiles, _onFault);
			Gateway.getInstance().call('profile.last_profiles', _responder);
		}
		
		private function _lastProfiles(result:Array):void
		{
			dispatchEvent(new ProfileEvent(ProfileEvent.LAST_PROFILES, result));
		}
		
		public function creations():void
		{
			_responder = new Responder(function(result:Object):void {
				dispatchEvent(new CreationsEvent(CreationsEvent.CREATIONS_LOADED, result));
			}, _onFault);
			Gateway.getInstance().call('profile.creations', _responder);
		}
		
		public function release(posX:int, posY:int, issueSlug:String):void
		{
			_responder = new Responder(function(result:Object):void {
				dispatchEvent(new CreationsEvent(CreationsEvent.CREATION_RELEASED));
			}, _onFault);
			Gateway.getInstance().call('square.release', _responder, posX, posY, issueSlug);
		}
		
		private function _updated(result:Object):void
		{
			if(result){
				dispatchEvent(new ProfileEvent(ProfileEvent.SUCCESS));
			}
		}
	}
}