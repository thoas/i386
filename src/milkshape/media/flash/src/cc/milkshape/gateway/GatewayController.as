package cc.milkshape.gateway
{
	import flash.events.NetStatusEvent;
	import flash.net.Responder;
	
	import cc.milkshape.gateway.Gateway;
	
	import flash.events.EventDispatcher;
	import cc.milkshape.user.User;
	
	public class GatewayController extends EventDispatcher
	{
		protected var _responder:Responder;
		public function GatewayController()
		{
			Gateway.getInstance().addEventListener(NetStatusEvent.NET_STATUS, _netStatus);
			_responder = new Responder(_onResult, _onFault);
		}

		public function getUser():User
		{
			return User.getInstance();
		}
		
		protected function _netStatus(e:NetStatusEvent):void
		{
			
		}
		
		protected function _onResult(result:Object):void 
		{
			trace(result);
		}
		
		protected function _onFault(error:Object):void 
		{
			for(var d:String in error)
			{
				trace(error[d] + "\n");
			}
		}
	}
}