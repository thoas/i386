package cc.milkshape.artists
{
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.artists.events.ArtistsEvent;
	
	import flash.net.Responder;

	public class ArtistsController extends GatewayController
	{
		public function issues():void
		{
			_responder = new Responder(
				function(result:Array):void
				{
					dispatchEvent(new ArtistsEvent(ArtistsEvent.SQUARES_BY_ISSUES_LOADED, result));
				},
			_onFault);
			Gateway.getInstance().call('square.full_by_issues', _responder);
		}	
	}
}