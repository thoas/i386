package cc.milkshape.gateway
{
	import cc.milkshape.framework.mvc.Controller;
	
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import nl.demonsters.debugger.MonsterDebugger;
	
	import cc.milkshape.utils.Constance;
	
	public class GatewayController extends Controller
	{
		protected var _gateway:NetConnection;
		protected var _responder:Responder;
		public function GatewayController()
		{
			_gateway = new NetConnection();
			_gateway.addEventListener(NetStatusEvent.NET_STATUS, _netStatus)
			_responder = new Responder(_onResult, _onFault);
		}
		
		protected function _connect(URI:String):void
		{
			_gateway.connect(Constance.url(URI));
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