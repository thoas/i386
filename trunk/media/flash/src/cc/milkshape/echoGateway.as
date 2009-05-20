package 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.net.NetConnection;
	import flash.net.Responder;

	public class echoGateway extends MovieClip 
	{		
		private var _gateway:NetConnection;
		public function echoGateway() 
		{
			_gateway = new NetConnection();
			_gateway.connect( "http://localhost:8000/square/gateway/");
			var param:String = "Hello World!";
			var responder:Responder = new Responder( onResult, onFault );
			_gateway.call( "square.echo", responder, param );
		}

		private function onResult( result:Object ): void {
			var myData:String = result.toString();
			trace( result );// prints "Hello World!"
			trace(myData)
		}
		private function onFault( error:Object ): void {
			for (var d:String in error) {
				trace(error[d] + "\n") 
			}
		}

	}
}