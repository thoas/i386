package 
{
	import flash.display.MovieClip;
	import flash.net.NetConnection;
	import flash.net.Responder;

	public class AuthentificationGateway extends MovieClip 
	{		
		private var _gateway:NetConnection;

		public function AuthentificationGateway() 
		{
			_gateway = new NetConnection();
			_gateway.connect("http://localhost:8000/account/gateway/");

			var responder:Responder = new Responder(onResult, onFault);

			_gateway.call("account.login", responder, "thoas", "vxwv");
		}

		private function onResult(result:Object): void {
			var myData:String = result.toString();
			trace(result);
		}

		private function onFault(error:Object): void {
			for (var d:String in error) {
				trace(error[d] + "\n") 
			}
		}

	}
}