package cc.milkshape.gateway
{
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import nl.demonsters.debugger.MonsterDebugger;
	
	import cc.milkshape.utils.Constance;
	import cc.milkshape.gateway.Gateway;
	
	import flash.events.EventDispatcher;
	import cc.milkshape.user.User;
	
	public class GatewayController extends EventDispatcher
	{
		protected var _responder:Responder;
		public function GatewayController()
		{
			Gateway.getInstance().addEventListener(NetStatusEvent.NET_STATUS, _netStatus)
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
			var myData:String = result.toString();
			MonsterDebugger.trace(this, result, 0xFF0000, true, 6);
			trace(result);
		}
		
		protected function _onFault(error:Object):void 
		{
			for (var d:String in error) {
				trace(error[d] + "\n") 
			}
		}
	}
}